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

@implementation CCCitySelectionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    
    CCCitySelectionController *citySelection = [CCCitySelectionController new];
    citySelection.stateID = object;
    CCCollegeSelectionTransaction *collegeTransaction = [CCCollegeSelectionTransaction new];
    collegeTransaction.arrayOfColleges = self.arrayOfColleges;
    collegeTransaction.navigation = self.navigation;
    citySelection.collegeScreenTransaction = collegeTransaction;
    [self.navigation pushViewController:citySelection animated:YES];
    
    
}

@end
