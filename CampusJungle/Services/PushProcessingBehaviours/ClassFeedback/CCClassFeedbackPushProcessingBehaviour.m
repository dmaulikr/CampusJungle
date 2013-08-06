//
//  CCClassFeedbackPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassFeedbackPushProcessingBehaviour.h"
#import "CCAPIProviderProtocol.h"
#import "CCVoteScreenTransaction.h"
#import "CCNavigationHelper.h"
#import "CCAlertHelper.h"
#import "CCStandardErrorHandler.h"

#import "MBProgressHUD+Status.h"

typedef void(^LoadClassSuccessBlock)(id);

@interface CCClassFeedbackPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCClassFeedbackPushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goCouponsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goCouponsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goCouponsWithUserInfo:userInfo];
    }];
}

- (void)goCouponsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *classId = [userInfo objectForKey:@"class_id"];
    [self loadClassWithId:classId successBlock:^(id classObject) {
        CCVoteScreenTransaction *voteTransaction = [CCVoteScreenTransaction new];
        voteTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [voteTransaction performWithObject:classObject];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingVoteDetails];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
