//
//  CCSelectUserGroupsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectUserGroupsTransaction.h"
#import "CCSelectGroupsViewController.h"

@implementation CCSelectUserGroupsTransaction

- (void)performWithObject:(id)object
{
    CCSelectGroupsViewController *selectGroupViewController = [CCSelectGroupsViewController new];
    [self.navigation pushViewController:selectGroupViewController animated:YES];
}

@end
