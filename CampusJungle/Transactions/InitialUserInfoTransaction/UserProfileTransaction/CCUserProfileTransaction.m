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
#import "CCMyStuffTransaction.h"
#import "CCSearchCollegeTransaction.h"

@implementation CCUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCUserProfile *userProfileController = [CCUserProfile new];

    CCLogoutTransaction *logoutTransaction = [CCLogoutTransaction new];
    logoutTransaction.rootMenuController = self.menuController;
    
    CCMyStuffTransaction *myStuffTransaction = [CCMyStuffTransaction new];

    userProfileController.myStuffTransaction = myStuffTransaction;
    CCMyNotesTransaction *myNotesTransaction = [CCMyNotesTransaction new];
    userProfileController.myNotesTransaction = myNotesTransaction;
    userProfileController.logoutTransaction = logoutTransaction;
    
    userProfileController.arrayOfEducations = [NSMutableArray new];
    userProfileController.sidePanelController = self.menuController;
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:userProfileController];
    
    self.menuController.centerPanel = centralNavigation;
 
    CCSearchCollegeTransaction *searchTransaction = [CCSearchCollegeTransaction new];
    searchTransaction.navigation = centralNavigation;
    searchTransaction.arrayOfColleges = userProfileController.arrayOfEducations;
    userProfileController.addColegeTransaction = searchTransaction;
    
    myNotesTransaction.navigation = centralNavigation;
    myStuffTransaction.navigation = centralNavigation;
}

@end
