//
//  CCSelectCollegeClassesTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectCollegeClassesTransaction.h"
#import "CCCollegesListController.h"

@implementation CCSelectCollegeClassesTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCCollegesListController *listOfColleges = [[CCCollegesListController alloc] initWithArray:object];
    [self.navigation pushViewController:listOfColleges animated:YES];    
}

@end
