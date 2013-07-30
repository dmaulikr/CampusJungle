//
//  CCNavigationHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNavigationHelper.h"
#import "CCSideBarController.h"

@implementation CCNavigationHelper

+ (UINavigationController *)activeNavigationController
{
    CCSideBarController *rootViewController = (CCSideBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    return (UINavigationController *)[rootViewController centerPanel];
}

@end
