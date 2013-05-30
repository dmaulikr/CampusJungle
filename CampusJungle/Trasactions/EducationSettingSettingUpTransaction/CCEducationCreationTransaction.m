//
//  CCEducationSettingUpTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducationCreationTransaction.h"
#import "CCEducationCreationController.h"
#import "CCBackToUserProfileTransaction.h"
#import "CCCollege.h"

@implementation CCEducationCreationTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    
    CCCollege *college = (CCCollege *)object;
    CCEducationCreationController *educationCreationController = [CCEducationCreationController new];
    CCBackToUserProfileTransaction *backToUserTransaction = [CCBackToUserProfileTransaction new];
    backToUserTransaction.arrayOfColleges = self.arrayOfColleges;
    backToUserTransaction.navigation = self.navigation;
    educationCreationController.collegeName = college.name;
    educationCreationController.collegeID = college.collegeID;
    educationCreationController.backToUserTransaction = backToUserTransaction;
    [self.navigation pushViewController:educationCreationController animated:YES];
}

@end
