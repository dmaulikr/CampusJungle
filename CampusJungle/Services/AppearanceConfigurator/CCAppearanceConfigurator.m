//
//  CCAppearanceConfigurator.m
//  CampusJungle
//
//  Created by Vlad Korzun on 27.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppearanceConfigurator.h"

@implementation CCAppearanceConfigurator

+ (void)configurate
{
    UIImage *navBackgroundImage = [[UIImage imageNamed:@"navigation_bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *barButtonImage = [[UIImage imageNamed:@"action_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
       UITextAttributeTextColor : [UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1]
     } forState:UIControlStateNormal];
    
    UIImage *customButtonBackground = [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
    
    UIImage *customButtonActiveBackground = [UIImage imageNamed:@"button_active"];
    
    [[UIButton appearance] setBackgroundImage:customButtonBackground forState:UIControlStateNormal];
    
    [[UIButton appearance] setBackgroundImage:customButtonActiveBackground forState:UIControlStateHighlighted];
    
    [[UILabel appearanceWhenContainedIn:[UIButton class], nil] setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:17]];
    
    [[UILabel appearanceWhenContainedIn:[UIButton class], nil] setTextColor:[UIColor yellowColor]];
    
    [[UISearchBar appearance] setTintColor:[UIColor brownColor]];
    
    [[UITextField appearance] setBackground:[[UIImage imageNamed:@"input_field"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    [[UITextField appearance] setBorderStyle:UITextBorderStyleNone];
    
    [[UITableViewCell appearance] setAccessoryType:UITableViewCellAccessoryNone];
}

@end
