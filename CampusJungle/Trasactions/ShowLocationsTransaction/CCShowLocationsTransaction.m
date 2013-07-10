//
//  CCShowLocationsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCShowLocationsTransaction.h"
#import "CCLocationsViewController.h"

@implementation CCShowLocationsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    id location = [object valueForKey:@"location"];
    NSString *classId = [object valueForKey:@"classId"];
    NSString *searchString = [object valueForKey:@"searchString"];
    NSArray *locationsArray = [object valueForKey:@"array"];
    
    CCLocationsViewController *locationsController = [[CCLocationsViewController alloc] initWithLocationsArray:locationsArray];
    [locationsController setSelectedLocation:location];
    [locationsController setClassId:classId];
    [locationsController setSearchString:searchString];
    [self.navigation pushViewController:locationsController animated:YES];
}

@end
