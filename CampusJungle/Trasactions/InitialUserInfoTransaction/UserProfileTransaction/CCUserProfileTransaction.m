//
//  CCUserProfileTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 24.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserProfileTransaction.h"
#import "CCUserProfile.h"
#import "CCLogoutTransaction.h"
#import "CCStateSelectionScreenTransaction.h"

@implementation CCUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCUserProfile *userProfileController = [CCUserProfile new];

    CCLogoutTransaction *logoutTransaction = [CCLogoutTransaction new];
    logoutTransaction.rootMenuController = self.menuController;
    userProfileController.logoutTransaction = logoutTransaction;
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:userProfileController];
    
    self.menuController.centerPanel = centralNavigation;
    
    CCStateSelectionScreenTransaction *stateSelectionTransaction = [CCStateSelectionScreenTransaction new];
    stateSelectionTransaction.navigation = centralNavigation;
    userProfileController.addColegeTransaction = stateSelectionTransaction;
}

@end
