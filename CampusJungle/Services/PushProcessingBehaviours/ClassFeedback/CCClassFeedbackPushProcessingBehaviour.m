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

typedef void(^LoadClassSuccessBlock)(id);

@interface CCClassFeedbackPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> voteTransaction;
@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCClassFeedbackPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.voteTransaction = [CCVoteScreenTransaction new];
        [(CCVoteScreenTransaction *)self.voteTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

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
    __weak CCClassFeedbackPushProcessingBehaviour *weakSelf = self;
    NSString *classId = [userInfo objectForKey:@"class_id"];
    [self loadClassWithId:classId successBlock:^(id classObject) {
        [weakSelf.voteTransaction performWithObject:classObject];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingVoteDetails];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
