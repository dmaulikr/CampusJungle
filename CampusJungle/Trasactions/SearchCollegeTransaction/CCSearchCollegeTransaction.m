//
//  CCSearchCollegeTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSearchCollegeTransaction.h"
#import "CCCollegeSearchController.h"
#import "CCStateSelectionScreenTransaction.h"
#import "CCEducationCreationTransaction.h"

@implementation CCSearchCollegeTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    CCCollegeSearchController *searchController = [CCCollegeSearchController new];
    
    CCEducationCreationTransaction *educationCreation = [CCEducationCreationTransaction new];
    educationCreation.navigation = self.navigation;
    educationCreation.arrayOfColleges = self.arrayOfColleges;
    
    searchController.createEducationTransaction = educationCreation;
    
    CCStateSelectionScreenTransaction *stateSelectionTransaction = [CCStateSelectionScreenTransaction new];
    stateSelectionTransaction.arrayOfColleges = self.arrayOfColleges;
    stateSelectionTransaction.navigation = self.navigation;
    searchController.createCollegeTransaction = stateSelectionTransaction;
    
    [self.navigation pushViewController:searchController animated:YES];

}

@end
