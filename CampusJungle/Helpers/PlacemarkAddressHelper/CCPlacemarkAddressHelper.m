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
    NSMutableString *resultString = [NSMutableString new];
    NSString *street = [[placemark addressDictionary] valueForKey:@"Street"];
    NSString *city = [[placemark addressDictionary] valueForKey:@"City"];
    NSString *state = [[placemark addressDictionary] valueForKey:@"State"];
    NSString *country = [[placemark addressDictionary] valueForKey:@"Country"];
    
    if ([street length] > 0) {
        [resultString appendFormat:@"%@, ", street];
    }
    if ([city length] > 0) {
        [resultString appendFormat:@"%@, ", city];
    }
    if ([state length] > 0) {
        [resultString appendFormat:@"%@, ", state];
    }
    if ([country length] > 0) {
        [resultString appendFormat:@"%@, ", country];
    }
    
    if ([resultString length] > 0) {
        return [resultString substringToIndex:[resultString length] - 2];
    }
    return @"Unknown";
}

@end
