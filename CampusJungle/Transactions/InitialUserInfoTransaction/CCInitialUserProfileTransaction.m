//
//  CCInitialUserInfoTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInitialUserProfileTransaction.h"
#import "CCUserProfile.h"
#import "CCUserProfileTransaction.h"
#import "CCInitialUserInfoController.h"
#import "CCInviterTransaction.h"
#import "CCTutorialTransaction.h"

@implementation CCInitialUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.loginTransaction);
    NSParameterAssert(self.navigation);
    
    CCTutorialTransaction *tutorialTransaction = [CCTutorialTransaction new];
    tutorialTransaction.navigation = self.navigation;
    tutorialTransaction.loginTransaction = self.loginTransaction;
    
    CCInviterTransaction *inviterTransaction = [CCInviterTransaction new];
    inviterTransaction.navigation = self.navigation;
    inviterTransaction.tutorialTransaction = tutorialTransaction;
    
    CCInitialUserInfoController *initialController = [CCInitialUserInfoController new];
    
    initialController.loginTrnasaction = inviterTransaction;
    [self.navigation pushViewController:initialController animated:YES];
}

@end
