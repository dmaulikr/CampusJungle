//
//  CCGroupInvitePushProcessingBahaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupInvitePushProcessingBehaviour.h"
#import "CCAlertHelper.h"
#import "CCNavigationHelper.h"
#import "CCInboxNavigationTransaction.h"

@interface CCGroupInvitePushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> inboxTransaction;

@end

@implementation CCGroupInvitePushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.inboxTransaction = [CCInboxNavigationTransaction new];
        [(CCInboxNavigationTransaction *)self.inboxTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

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
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goForumDetailsWithUserInfo:userInfo];
    }];
}

- (void)goForumDetailsWithUserInfo:(NSDictionary *)userInfo
{
    [self.inboxTransaction performWithObject:@{@"selectedTabIndex" : @(1)}];
}

@end
