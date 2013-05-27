//
//  CCSignUpTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSignUpTransaction.h"
#import "CCSignUPController.h"

@implementation CCSignUpTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.initialUserInfoTransaction);
    
    CCSignUPController *signUpController = [CCSignUPController new];
    signUpController.initialUserInfoTransaction = self.initialUserInfoTransaction;
    
    [self.navigation pushViewController:signUpController animated:YES];
}

@end