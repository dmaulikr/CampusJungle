//
//  CCFacebookRequestParseHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFacebookRequestParseHelper.h"

@implementation CCFacebookRequestParseHelper

+ (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

@end
