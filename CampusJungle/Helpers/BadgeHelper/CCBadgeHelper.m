//
//  CCBadgeHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "CCBadgeHelper.h"

@implementation CCBadgeHelper

+ (void)resetApplicationIconBadge
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

@end
