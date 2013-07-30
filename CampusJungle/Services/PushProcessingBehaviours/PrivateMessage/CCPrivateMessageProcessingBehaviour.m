//
//  CCPrivateMessageProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPrivateMessageProcessingBehaviour.h"
#import "CCNavigationHelper.h"
#import "CCMessageDetailsTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCAlertHelper.h"

@interface CCPrivateMessageProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> messageDetailsTransaction;

@end

@implementation CCPrivateMessageProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.messageDetailsTransaction = [CCMessageDetailsTransaction new];
        [(CCMessageDetailsTransaction *)self.messageDetailsTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goMessageDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goMessageDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goMessageDetailsWithUserInfo:userInfo];
    }];
}

- (void)goMessageDetailsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *messageid = [userInfo objectForKey:@"message_id"];
    [self.messageDetailsTransaction performWithObject:messageid];    
}

@end
