//
//  CCSelectFiltersTranaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectFiltersTranaction.h"
#import "CCFilterController.h"

@implementation CCSelectFiltersTranaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCFilterController *filterController = [CCFilterController new];
    
    [self.navigation pushViewController:filterController animated:YES];
}

@end
