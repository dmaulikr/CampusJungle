//
//  CCNote.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNote.h"

@implementation CCNote

- (NSString *)description
{
    return self.noteDescription;
}

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"noteID",
      @"owner_id" : @"ownerID",
      @"college_id" : @"collegeID",
      @"class_id" : @"classID",
      @"description" : @"noteDescription",
      @"price" : @"price",
      @"full_access_price" : @"fullPrice",
      @"tags" : @"tags",
      @"thumbnail" : @"thumbnail",
      @"thumbnail_retina" : @"thumbnailRetina",
      @"attachment" : @"link",
      @"full_access" : @"fullAccess",
    };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
      @"classID" : @"class_id",
      @"noteDescription" : @"description",
      @"price" : @"price",
      @"fullPrice" : @"full_access_price",
      @"tags" : @"tags",
      @"pdfUrl" : @"pdf_url",
      @"arrayOfURLs" :@"images_urls",
      @"thumbnail" : @"thumbnail",
    };
}

+ (NSDictionary *)noteLinkMappingDictionary
{
    return @{
      @"note_url" : @"link",
    };
}

@end
