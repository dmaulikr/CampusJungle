//
//  CCDateFormatterHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDateFormatterHelper.h"

@interface CCDateFormatterHelper ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation CCDateFormatterHelper

- (id)init
{
    self = [super init];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setLocale:[NSLocale systemLocale]];
        [self.dateFormatter setDateFormat:@"hh:mma dd/MM/yy"];
    }
    return self;
}

- (NSString *)formatedDateStringFromDate:(NSDate *)date
{
    return [self.dateFormatter stringFromDate:date];
}

@end
