//
//  CCClassesOfcurrentCollegeTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesOfcurrentCollegeTransaction.h"
#import "CCCollegeClassesController.h"
#import "CCAddClassTransaction.h"

@implementation CCClassesOfcurrentCollegeTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);

    CCCollegeClassesController *classesController = [[CCCollegeClassesController alloc] initWithCollegeID:object];
    CCAddClassTransaction *addClassTransaction = [CCAddClassTransaction new];
    addClassTransaction.navigation = self.navigation;
    classesController.addNewClassTransaction = addClassTransaction;
    [self.navigation pushViewController:classesController animated:YES];
}

@end
