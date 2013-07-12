//
//  CCGroup.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroup.h"

@implementation CCGroup

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"id" : @"groupId",
             @"description" : @"description",
             @"name" : @"name",
             @"owner_id" : @"ownerId",
             @"klass_id" : @"classId",
             @"image_retina" : @"image",
             };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
             @"groupId" : @"id",
             @"description" : @"description",
             @"name" : @"name",
             @"ownerId" : @"owner_id",
             @"classId" : @"class_id",
             @"image" : @"image",
             };
}

@end
