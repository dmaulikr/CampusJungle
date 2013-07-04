//
//  CCAuthorizationResponse.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAuthorizationResponse.h"

@implementation CCAuthorizationResponse

+ (NSDictionary *)responseMappingDictionary
{
    return @{
             @"is_new_user" : @"isFirstLaunch",
    };
}

@end
