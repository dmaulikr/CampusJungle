//
//  CCCity.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCity.h"

@implementation CCCity

+ (NSDictionary *)responseMappingDictionary
{
    return @{
      @"id" : @"cityID",
      @"name" : @"name"
    };
}

@end
