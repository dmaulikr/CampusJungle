//
//  CCStuff.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuff.h"

@implementation CCStuff

- (NSString *)description
{
    return self.stuffDescription;
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"stuffID",
      @"owner_id" : @"ownerID",
      @"college_id" : @"collegeID",
      @"class_id" : @"classID",
      @"description" : @"stuffDescription",
      @"price" : @"price",
      @"tags" : @"tags",
      @"thumbnail" : @"thumbnail",
      @"thumbnail_retina" : @"thumbnailRetina",
    };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
      @"collegeID" : @"class_id",
      @"stuffDescription" : @"description",
      @"price" : @"price",
      @"arrayOfURLs" :@"images",
    };
}

@end
