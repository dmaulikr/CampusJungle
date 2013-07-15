//
//  CCForum.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCForum.h"

@implementation CCForum

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"forumId",
             @"description" : @"description",
             @"name" : @"name",
             @"owner_id" : @"ownerId",
             @"questions_count" : @"questionsCount",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"description" : @"description",
             @"name" : @"name",
             };
}

@end
