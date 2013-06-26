//
//  CCCitySelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCitySelectionTransaction.h"
#import "CCCitySelectionController.h"
#import "CCCollegeSelectionTransaction.h"
#import "CCEducationCreationTransaction.h"

@implementation CCCitySelectionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    
    CCCitySelectionController *citySelection = [CCCitySelectionController new];
    citySelection.stateID = [object stateID];
    citySelection.title = [object name];
    
//    CCCollegeSelectionTransaction *collegeTransaction = [CCCollegeSelectionTransaction new];
//    collegeTransaction.arrayOfColleges = self.arrayOfColleges;
//    collegeTransaction.navigation = self.navigation;
//    citySelection.collegeScreenTransaction = collegeTransaction;
   
    CCEducationCreationTransaction *educationCreation = [CCEducationCreationTransaction new];
    educationCreation.arrayOfColleges = self.arrayOfColleges;
    educationCreation.navigation = self.navigation;
    citySelection.educationTransaction = educationCreation;
    
    [self.navigation pushViewController:citySelection animated:YES];
}

@end
