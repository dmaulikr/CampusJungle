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

@implementation CCInitialUserProfileTransaction

- (void)perform
{
    NSParameterAssert(self.loginTransaction);
    NSParameterAssert(self.navigation);
    
    CCInitialUserInfoController *initialController = [CCInitialUserInfoController new];
    initialController.loginTrnasaction = self.loginTransaction;
    [self.navigation pushViewController:initialController animated:YES];
}

@end
