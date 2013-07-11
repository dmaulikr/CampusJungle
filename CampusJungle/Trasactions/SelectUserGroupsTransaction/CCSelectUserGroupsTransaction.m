//
//  CCSelectUserGroupsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectUserGroupsTransaction.h"
#import "CCSelectGroupsViewController.h"
#import "CCBackTransaction.h"

@implementation CCSelectUserGroupsTransaction

- (void)performWithObject:(id)object
{
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCSelectGroupsViewController *selectGroupViewController = [CCSelectGroupsViewController new];
    selectGroupViewController.backTransaction = backTransaction;
    [self.navigation pushViewController:selectGroupViewController animated:YES];
}

@end
