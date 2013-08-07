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
#import "CCWalletTransaction.h"
#import "CCSettingsTransaction.h"
#import "CCMyBooksTransaction.h"
#import "CCChangePasswordTransaction.h"

@implementation CCUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCUserProfile *userProfileController = [CCUserProfile new];

    CCMyBooksTransaction *myBooksTransaction = [CCMyBooksTransaction new];
    userProfileController.myBooksTransaction = myBooksTransaction;
    
    CCWalletTransaction *walletTransaction = [CCWalletTransaction new];
    userProfileController.walletTransaction = walletTransaction;
    
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
    
    walletTransaction.navigation = centralNavigation;
    myBooksTransaction.navigation = centralNavigation;
    self.menuController.centerPanel = centralNavigation;
 
    CCSettingsTransaction *settingsTransaction = [CCSettingsTransaction new];
    settingsTransaction.navigation = centralNavigation;
    userProfileController.settingsTransaction = settingsTransaction;
    
    CCSearchCollegeTransaction *searchTransaction = [CCSearchCollegeTransaction new];
    searchTransaction.navigation = centralNavigation;
    searchTransaction.arrayOfColleges = userProfileController.arrayOfEducations;
    userProfileController.addColegeTransaction = searchTransaction;
    
    CCChangePasswordTransaction *changePasswordTransaction = [CCChangePasswordTransaction new];
    changePasswordTransaction.navigation = centralNavigation;
    userProfileController.changePasswordTransaction = changePasswordTransaction;
    
    myNotesTransaction.navigation = centralNavigation;
    myStuffTransaction.navigation = centralNavigation;
}

@end
