//
//  CCCitySelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCitySelectionTransaction.h"
#import "CCCitySelectionController.h"

@implementation CCCitySelectionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCCitySelectionController *citySelection = [CCCitySelectionController new];
    citySelection.stateID = object;
    [self.navigation pushViewController:citySelection animated:YES];
}

@end
