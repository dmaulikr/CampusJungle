//
//  CCCollege.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollege.h"

@implementation CCCollege

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"collegeID",
      @"name" : @"name",
      @"address" : @"address"
    };
}

@end
