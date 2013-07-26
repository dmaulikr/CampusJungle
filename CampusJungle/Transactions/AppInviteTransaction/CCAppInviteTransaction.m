//
//  CCAppInviteTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppInviteTransaction.h"
#import "CCAppInviteViewController.h"
#import "CCBackTransaction.h"

@implementation CCAppInviteTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAppInviteViewController *appInviteController = [CCAppInviteViewController new];
    [appInviteController setClassObject:object];
    appInviteController.backTransaction = backTransaction;
    [self.navigation pushViewController:appInviteController animated:YES];
}

@end
