//
//  CCCollegeSelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSelectionTransaction.h"
#import "CCCollegeSelectionController.h"
#import "CCEducationCreationTransaction.h"

@implementation CCCollegeSelectionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    
    CCCollegeSelectionController *collegeSelectionController = [CCCollegeSelectionController new];
    collegeSelectionController.cityID = [object cityID];
    CCEducationCreationTransaction *educationTransaction = [CCEducationCreationTransaction new];
    educationTransaction.arrayOfColleges = self.arrayOfColleges;
    educationTransaction.navigation = self.navigation;
    collegeSelectionController.educationTransaction = educationTransaction;
    
    [self.navigation pushViewController:collegeSelectionController animated:YES];
}

@end
