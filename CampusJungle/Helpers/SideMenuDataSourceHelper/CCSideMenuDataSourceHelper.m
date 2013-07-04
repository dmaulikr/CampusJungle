//
//  CCSideMenuDataSourceHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuDataSourceHelper.h"

@implementation CCSideMenuDataSourceHelper

+ (NSArray *)menuSectionsArrayWithEducationsArray:(NSArray *)educationsArray
{
    NSMutableArray *sectionsArray = [NSMutableArray arrayWithObject:[self fakeFirstMenuSectionDictionary]];
    [sectionsArray addObjectsFromArray:[self sectionsArrayWithEducationsArray:educationsArray]];
    return sectionsArray;
}

+ (NSDictionary *)fakeFirstMenuSectionDictionary
{
    return @{@"name" : @"",
             @"items" : @[CCSideMenuTitles.newsFeed, CCSideMenuTitles.marketPlace]};
}

+ (NSArray *)sectionsArrayWithEducationsArray:(NSArray *)educationsArray
{
    NSMutableArray *sectionsArray = [NSMutableArray array];
    for (NSDictionary *sectionDataDictionary in educationsArray) {
        NSDictionary *sectionDictionary = @{@"name" : sectionDataDictionary[@"collegeName"],
                                            @"items" : sectionDataDictionary[@"classes"]};
        [sectionsArray addObject:sectionDictionary];
    }
    return sectionsArray;
}

@end
