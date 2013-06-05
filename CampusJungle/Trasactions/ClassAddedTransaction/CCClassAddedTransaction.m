//
//  CCClassAddedTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/6/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassAddedTransaction.h"

@implementation CCClassAddedTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    [self.navigation popToRootViewControllerAnimated:YES];
}

@end
