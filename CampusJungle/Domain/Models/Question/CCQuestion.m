//
//  CCQuestion.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestion.h"

@implementation CCQuestion

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"questionId",
             @"forum_id" : @"forumId",
             @"text" : @"text",
             @"owner_id" : @"ownerId",
             @"attachment" : @"attachment",
             @"answers_count" : @"answersCount",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"text" : @"text",
             @"attachment" : @"attachment",
             };
}

@end
