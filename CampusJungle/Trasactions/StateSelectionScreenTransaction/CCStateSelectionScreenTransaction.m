//
//  CCStateSelectionScreenTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStateSelectionScreenTransaction.h"
#import "CCStateSelectionConroller.h"
#import "CCCitySelectionTransaction.h"

@implementation CCStateSelectionScreenTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.arrayOfColleges);
    
    CCStateSelectionConroller *stateSelectionController = [CCStateSelectionConroller new];
    CCCitySelectionTransaction *citySelectionTransaction = [CCCitySelectionTransaction new];
    citySelectionTransaction.arrayOfColleges = self.arrayOfColleges;
    citySelectionTransaction.navigation = self.navigation;
    stateSelectionController.citySelectionTransaction = citySelectionTransaction;
    [self.navigation pushViewController:stateSelectionController animated:YES];
}

@end
