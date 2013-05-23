//
//  CCInitialUserInfoTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInitialUserInfoTransaction.h"
#import "CCInitialUserInfoController.h"

@implementation CCInitialUserInfoTransaction

- (void)perform
{
    NSParameterAssert(self.loginTransaction);
    NSParameterAssert(self.navigation);
    
    CCInitialUserInfoController *initialController = [CCInitialUserInfoController new];
    initialController.loginTransaction = self.loginTransaction;
    [self.navigation pushViewController:initialController animated:YES];
}

@end
