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

@implementation CCInitialUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.loginTransaction);
    NSParameterAssert(self.baseViewController);
    
    [self.loginTransaction perform];
    CCUserProfileTransaction *profileTransaction = [CCUserProfileTransaction new];
    profileTransaction.menuController = self.baseViewController;

    [profileTransaction perform];
}

@end
