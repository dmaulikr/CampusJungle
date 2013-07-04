//
//  CCLoginTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginTransaction.h"
#import "CCUserProfileTransaction.h"

@implementation CCLoginTransaction

- (void)perform
{
    [self.menuController dismissViewControllerAnimated:YES completion:nil];
    CCUserProfileTransaction *profileTransaction = [CCUserProfileTransaction new];
    profileTransaction.menuController = self.menuController;
    [profileTransaction perform];
}

@end
