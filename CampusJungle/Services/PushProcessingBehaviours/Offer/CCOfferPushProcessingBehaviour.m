//
//  CCOfferPushProcessingBahaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOfferPushProcessingBehaviour.h"
#import "CCAlertHelper.h"
#import "CCNavigationHelper.h"
#import "CCInboxNavigationTransaction.h"

@interface CCOfferPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> inboxTransaction;

@end

@implementation CCOfferPushProcessingBehaviour

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
    [self.inboxTransaction performWithObject:@{@"selectedTabIndex" : @(2)}];
}

@end
