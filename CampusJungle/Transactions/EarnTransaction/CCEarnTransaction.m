//
//  CCEarnTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 02.09.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEarnTransaction.h"
#import "CCAppInviteTransaction.h"

@implementation CCEarnTransaction

- (void)perform
{
    UINavigationController *centralNavigation = [[UINavigationController alloc] init];
    self.menuController.centerPanel = centralNavigation;
    CCAppInviteTransaction *invitesTransaction = [CCAppInviteTransaction new];
    invitesTransaction.navigation = centralNavigation;
    [invitesTransaction performWithObject:[NSNull null]];
}

@end
