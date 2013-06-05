//
//  CCSelectCollegeClassesTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectCollegeClassesTransaction.h"
#import "CCCollegesListController.h"
#import "CCClassesOfcurrentCollegeTransaction.h"

@implementation CCSelectCollegeClassesTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCCollegesListController *listOfColleges = [[CCCollegesListController alloc] initWithArray:object];
    CCClassesOfcurrentCollegeTransaction *classesOfCollege = [CCClassesOfcurrentCollegeTransaction new];
    classesOfCollege.navigation = self.navigation;
    listOfColleges.classesOfcurrentCollegeTransaction = classesOfCollege;
    
    [self.navigation pushViewController:listOfColleges animated:YES];    
}

@end
