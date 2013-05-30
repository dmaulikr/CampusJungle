//
//  CCBackToUserProfileTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToUserProfileTransaction.h"

@implementation CCBackToUserProfileTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    [self.arrayOfColleges addObject:object];
    [self.navigation popToRootViewControllerAnimated:YES];
    
}

@end
