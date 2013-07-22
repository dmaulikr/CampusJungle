//
//  CCAddLocationTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddLocationTransaction.h"
#import "CCAddLocationViewController.h"

#import "CCSelectUserClassmatesTransaction.h"
#import "CCSelectUserGroupsTransaction.h"
#import "CCBackTransaction.h"

@implementation CCAddLocationTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(object);
    NSParameterAssert(self.navigation);
    
    CCSelectUserClassmatesTransaction *selectClassmatesToShareTransaction = [CCSelectUserClassmatesTransaction new];
    selectClassmatesToShareTransaction.navigation = self.navigation;
    
    CCSelectUserGroupsTransaction *selectGroupToShareTransaction = [CCSelectUserGroupsTransaction new];
    selectGroupToShareTransaction.navigation = self.navigation;
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddLocationViewController *addLocationController = [CCAddLocationViewController new];
    addLocationController.locationToAddObject = object;
    addLocationController.selectGroupToShareTransaction = selectGroupToShareTransaction;
    addLocationController.selectUsersToShareTransaction = selectClassmatesToShareTransaction;
    addLocationController.backTransaction = backTransaction;
    [self.navigation pushViewController:addLocationController animated:YES];
}

@end
