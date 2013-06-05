//
//  CCAllClassesTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAllClassesTransaction.h"
#import "CCClassesController.h"
#import "CCClassTransaction.h"
#import "CCSelectCollegeClassesTransaction.h"
#import "CCUserProfileTransaction.h"
#import "CCClassesOfcurrentCollegeTransaction.h"


@implementation CCAllClassesTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCClassesController *classesController = [CCClassesController new];
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classesController];
    self.menuController.centerPanel = centralNavigation;
    
    CCSelectCollegeClassesTransaction *selectCollege = [CCSelectCollegeClassesTransaction new];
    selectCollege.navigation = centralNavigation;
    classesController.selectCollege = selectCollege;
    
    CCClassTransaction *classTransaction = [CCClassTransaction new];
    classTransaction.navigation = centralNavigation;
    classesController.classTransaction = classTransaction;
    
    CCUserProfileTransaction *userProfileTransaction = [CCUserProfileTransaction new];
    userProfileTransaction.menuController = self.menuController;
    classesController.userProfileTransaction = userProfileTransaction;
    
    CCClassesOfcurrentCollegeTransaction *classesOfCollege = [CCClassesOfcurrentCollegeTransaction new];
    classesOfCollege.navigation = centralNavigation;
    classesController.selectClass = classesOfCollege;
}

@end
