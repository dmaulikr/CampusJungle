//
//  NSString+CountString.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "NSString+CountString.h"

@implementation NSString (CountString)

- (NSInteger)countOccurencesOfString:(NSString*)searchString {
    int strCount = [self length] - [[self stringByReplacingOccurrencesOfString:searchString withString:@""] length];
    return strCount / [searchString length];
}

@end
