//
//  CCLoginScreenTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginScreenTransaction.h"
#import "CCLoginController.h"

@implementation CCLoginScreenTransaction

- (void)perform
{
    NSParameterAssert(self.loginTransaction);
    NSParameterAssert(self.navigation);
    
    CCLoginController *loginController = [CCLoginController new];
    loginController.loginTransaction = self.loginTransaction;
    
    [self.navigation pushViewController:loginController animated:YES];
}

@end
