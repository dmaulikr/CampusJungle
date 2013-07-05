//
//  CCClass.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/3/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClass.h"

@implementation CCClass

- (NSString *)name
{
    return self.subject;
}

- (NSString *)description
{
    return self.subject;
}

+ (NSDictionary *)responseMappingDictionary
{
   return @{
      @"professor" : @"professor",
      @"timetable" : @"timetable",
      @"subject" : @"subject",
      @"semester" : @"semester",
      @"call_number":@"callNumber",
      @"id":@"classID",
      @"college_name" : @"collegeName",
      @"college_id" : @"collegeID",
      };
}

+ (NSDictionary *)requestMappingDictionary
{
    return @{
      @"professor" : @"professor",
      @"timetable" : @"timetable",
      @"subject" : @"subject",
      @"semester" : @"semester",
      @"call_number":@"callNumber",
      @"id":@"classID",
      @"college_name" : @"collegeName",
      };
}

@end
