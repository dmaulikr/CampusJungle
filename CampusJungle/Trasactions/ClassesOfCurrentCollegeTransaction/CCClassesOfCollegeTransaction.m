//
//  CCClassesOfcurrentCollegeTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesOfCollegeTransaction.h"
#import "CCClassesOfCollegeController.h"
#import "CCAddClassTransaction.h"
#import "CCClassAddedTransaction.h"

@implementation CCClassesOfCollegeTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.menuController);
    NSParameterAssert(object);

    CCClassesOfCollegeController *classesController = [[CCClassesOfCollegeController alloc] initWithCollegeID:object];
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classesController];
    
    CCAddClassTransaction *addClassTransaction = [CCAddClassTransaction new];
    addClassTransaction.navigation = centralNavigation;
    classesController.addNewClassTransaction = addClassTransaction;
    
    CCClassAddedTransaction *classAddedTransaction = [CCClassAddedTransaction new];
    classAddedTransaction.navigation = centralNavigation;
    classesController.classAddedTransaction = classAddedTransaction;
    
    [self.menuController setCenterPanel:centralNavigation];
}

@end
