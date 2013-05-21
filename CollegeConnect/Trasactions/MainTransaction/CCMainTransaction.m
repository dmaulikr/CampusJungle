//
//  CCMainTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMainTransaction.h"
#import "CCLoginController.h"
#import "CCUserSessionProtocol.h"

@interface CCMainTransaction()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMainTransaction

- (void)perform
{
    NSLog(@"%@",self.ioc_userSession);
    [self.window setRootViewController:[CCLoginController new]];
}

@end
