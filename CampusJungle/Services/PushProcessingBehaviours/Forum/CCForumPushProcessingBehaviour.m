//
//  CCForumPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCForumPushProcessingBehaviour.h"
#import "CCForumDetailsTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCForumsApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"
#import "CCNavigationHelper.h"

#import "MBProgressHUD+Status.h"

typedef void(^LoadForumSuccessBlock)(id);

@interface CCForumPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCForumsApiProviderProtocol> ioc_forumsApiProvider;

@end

@implementation CCForumPushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goForumDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goForumDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification message:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goForumDetailsWithUserInfo:userInfo];
    }];
}

- (void)goForumDetailsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *forumId = [userInfo objectForKey:@"forum_id"];
    [self loadForumWithId:forumId successBlock:^(id forum) {
        CCForumDetailsTransaction *transaction = [CCForumDetailsTransaction new];
        transaction.navigation = [CCNavigationHelper activeNavigationController];
        [transaction performWithObject:forum];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadForumWithId:(NSString *)forumId successBlock:(LoadForumSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingForum];
    [self.ioc_forumsApiProvider loadForumWithId:forumId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
