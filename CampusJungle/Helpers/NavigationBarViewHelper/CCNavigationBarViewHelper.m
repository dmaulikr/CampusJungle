//
//  CCNavigationBarViewHellper.m
//  CampusJungle
//
//  Created by Vlad Korzun on 03.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNavigationBarViewHelper.h"

@implementation CCNavigationBarViewHelper

+(UIBarButtonItem *)plusButtonWithTarget:(id)target action:(SEL)action
{
    UIImage *plusButton = [UIImage imageNamed:@"add_button"];
    UIImage *plusButtonSelected = [UIImage imageNamed:@"add_button_active"];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, plusButton.size.width, plusButton.size.height)];
    [button setBackgroundImage:plusButton forState:UIControlStateNormal];
    [button setBackgroundImage:plusButtonSelected forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];

}

@end
