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
    [self goOffersWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goOffersWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification message:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goOffersWithUserInfo:userInfo];
    }];
}

- (void)goOffersWithUserInfo:(NSDictionary *)userInfo
{
    [self.inboxTransaction performWithObject:@{@"selectedTabIndex" : @(2)}];
}

@end
