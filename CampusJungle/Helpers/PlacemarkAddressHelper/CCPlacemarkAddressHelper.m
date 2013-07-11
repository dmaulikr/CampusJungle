//
//  CCPlacemarkAddressHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPlacemarkAddressHelper.h"

@implementation CCPlacemarkAddressHelper

+ (NSString *)addressForPlacemark:(CLPlacemark *)placemark
{
    NSString *street = [[placemark addressDictionary] valueForKey:@"Street"];
    NSString *city = [[placemark addressDictionary] valueForKey:@"City"];
    NSString *state = [[placemark addressDictionary] valueForKey:@"State"];
    NSString *country = [[placemark addressDictionary] valueForKey:@"Country"];
    return [NSString stringWithFormat:@"%@, %@, %@, %@", street, city, state, country];
}

@end
