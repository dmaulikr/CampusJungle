//
//  CCButtonsHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCButtonsHelper.h"

@implementation CCButtonsHelper

+ (void)removeBackgroundImageInButton:(UIButton *)button
{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:nil forState:UIControlStateHighlighted];
}

@end
