//
//  CCTimeStringsSortingHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTimeStringsSortingHelper.h"
#import "NSDateFormatter+Locale.h"

@implementation CCTimeStringsSortingHelper

+ (NSString *)sortedTimesStringFromTimesStringsArray:(NSArray *)timesArray
{
    if ([timesArray count] == 0) {
        return @"";
    }
    
    timesArray = [NSArray arrayWithArray:[self sortArrayOfDateStrings:timesArray]];
    NSMutableString *resultString = [NSMutableString string];
    for (NSString *timeString in timesArray) {
        [resultString appendFormat:@"%@, ", timeString];
    }
    return [resultString substringToIndex:[resultString length] - 2];
}

+ (NSArray *)sortArrayOfDateStrings:(NSArray *)dateStrings
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] initWithSafeLocale];
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSMutableArray *datesArray = [NSMutableArray array];
    for (NSString *dateString in dateStrings) {
        NSDate *date = [dateFormatter dateFromString:dateString];
        [datesArray addObject:date];
    }
    
    datesArray = [[datesArray sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    
    NSMutableArray *sortedDateStringsArray = [NSMutableArray array];
    for (NSDate *date in datesArray) {
        NSString *stringDate = [dateFormatter stringFromDate:date];
        [sortedDateStringsArray addObject:stringDate];
    }
    return sortedDateStringsArray;
}

@end
