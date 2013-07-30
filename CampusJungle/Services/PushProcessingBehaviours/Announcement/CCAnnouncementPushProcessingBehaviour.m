//
//  CCAnnouncementPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementPushProcessingBehaviour.h"
#import "CCAPIProvider.h"
#import "CCTransactionWithObject.h"
#import "CCAnnouncementTransaction.h"
#import "CCAlertHelper.h"

typedef void(^LoadClassSuccessBlock)(id);

@interface CCAnnouncementPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, strong) id<CCTransactionWithObject> announcementTransaction;

@end

@implementation CCAnnouncementPushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goAnnouncementsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goAnnouncementsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goAnnouncementsWithUserInfo:userInfo];
    }];
}

- (void)goAnnouncementsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *classId = [userInfo objectForKey:@"class_id"];
    __weak CCAnnouncementPushProcessingBehaviour *weakSelf = self;
    [self loadClassWithId:classId successBlock:^(id classObject) {
        [weakSelf.announcementTransaction performWithObject:classObject];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingClass];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
