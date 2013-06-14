//
//  CCApplyFiltersTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 14.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCApplyFiltersTransaction.h"

@implementation CCApplyFiltersTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.marketPlace);
    
    self.marketPlace.filters = object;
    [self.marketPlace update];
    [self.navigation popViewControllerAnimated:YES];
}

@end
