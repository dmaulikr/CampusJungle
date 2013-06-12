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
#import "CCMyNotesTransaction.h"

@implementation CCUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCUserProfile *userProfileController = [CCUserProfile new];

    CCLogoutTransaction *logoutTransaction = [CCLogoutTransaction new];
    logoutTransaction.rootMenuController = self.menuController;
    CCMyNotesTransaction *myNotesTransaction = [CCMyNotesTransaction new];
    userProfileController.myNotesTransaction = myNotesTransaction;
    userProfileController.logoutTransaction = logoutTransaction;
    
    userProfileController.arrayOfEducations = [NSMutableArray new];
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:userProfileController];
    
    self.menuController.centerPanel = centralNavigation;
    
    CCStateSelectionScreenTransaction *stateSelectionTransaction = [CCStateSelectionScreenTransaction new];
    stateSelectionTransaction.arrayOfColleges = userProfileController.arrayOfEducations;
    stateSelectionTransaction.navigation = centralNavigation;
    userProfileController.addColegeTransaction = stateSelectionTransaction;
    myNotesTransaction.navigation = centralNavigation;
}

@end
