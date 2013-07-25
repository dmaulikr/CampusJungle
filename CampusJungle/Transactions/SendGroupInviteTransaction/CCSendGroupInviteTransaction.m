//
//  CCSendGroupInviteTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSendGroupInviteTransaction.h"
#import "CCGroupInviteViewController.h"

#import "CCBackTransaction.h"

@implementation CCSendGroupInviteTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCGroupInviteViewController *groupInviteController = [CCGroupInviteViewController new];
    groupInviteController.backTransaction = backTransaction;
    [groupInviteController setGroup:object];
    [self.navigation pushViewController:groupInviteController animated:YES];
}

@end
