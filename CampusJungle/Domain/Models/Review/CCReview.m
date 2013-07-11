//
//  CCReview.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReview.h"

@implementation CCReview

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"reviewID",
             @"text" : @"text",
             @"reviewer_id" : @"reviewerID",
             @"reviewed_id" : @"reviewedID",
             @"rank" : @"rank",
             };
}

- (NSString *)description
{
    return self.text;
}

@end
