//
//  CCShowLocationsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCShowLocationsTransaction.h"
#import "CCLocationsViewController.h"
#import "CCAddLocationTransaction.h"

@implementation CCShowLocationsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    id location = [object valueForKey:@"location"];
    id classObject = [object valueForKey:@"class"];
    id group = [object valueForKey:@"group"];
    NSString *searchString = [object valueForKey:@"searchString"];
    NSArray *locationsArray = [object valueForKey:@"array"];
    
    CCAddLocationTransaction *addLocationTransaction = [CCAddLocationTransaction new];
    addLocationTransaction.navigation = self.navigation;
    
    CCLocationsViewController *locationsController = [[CCLocationsViewController alloc] initWithLocationsArray:locationsArray];
    [locationsController setSelectedLocation:location];
    [locationsController setClass:classObject];
    [locationsController setGroup:group];
    [locationsController setSearchString:searchString];
    locationsController.addLocationTransaction = addLocationTransaction;
    [self.navigation pushViewController:locationsController animated:YES];
}

@end
