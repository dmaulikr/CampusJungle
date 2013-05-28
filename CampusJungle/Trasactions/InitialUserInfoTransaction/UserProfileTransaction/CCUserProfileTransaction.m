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

@implementation CCUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCUserProfile *userProfileController = [CCUserProfile new];

    CCLogoutTransaction *logoutTransaction = [CCLogoutTransaction new];
    logoutTransaction.rootMenuController = self.menuController;
    userProfileController.logoutTransaction = logoutTransaction;
    
    self.menuController.centerPanel = [[UINavigationController alloc] initWithRootViewController:userProfileController];
}

@end
