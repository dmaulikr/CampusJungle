//
//  CCSideMenuHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 05.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuHelper.h"
#import "CCSideBarController.h"
#import "CCNavigationHelper.h"

@implementation CCSideMenuHelper

+ (void)setSideMenuGestureEnabled:(BOOL)enabled
{
     CCSideBarController *sideBarController = (CCSideBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [sideBarController setAllowLeftSwipe:enabled];
}

@end
