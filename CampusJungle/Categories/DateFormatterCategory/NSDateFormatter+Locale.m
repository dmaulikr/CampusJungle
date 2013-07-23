//
//  NSDateFormatter+Locale.m
//  CampusJungle
//
//  Created by Yury Grinenko on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "NSDateFormatter+Locale.h"

@implementation NSDateFormatter (Locale)

- (id)initWithSafeLocale
{
    static NSLocale *en_US_POSIX = nil;
    self = [self init];
    if (en_US_POSIX == nil) {
        en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    [self setLocale:en_US_POSIX];
    return self;
}

@end

