//
//  CCAppearanceConfigurator.m
//  CampusJungle
//
//  Created by Vlad Korzun on 27.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppearanceConfigurator.h"
#import "CCBaseViewController.h"
#import "CCDefaultButtonContainer.h"
#import "CCClearButton.h"

@implementation CCAppearanceConfigurator

+ (void)configurate
{
    [self configurateTextFields];
    [self configurateNavigationBar];
    [self configurateBarButtons];
    [self configurateButtons];
    [self configurateSegmentController];
    [self configurateProgressHuds];
    [self configurateSwitch];
    [self configurateClearButtons];
}

+ (void)configurateClearButtons
{
    [[CCClearButton appearance] setBackgroundImage:nil forState:UIControlStateNormal];
    [[CCClearButton appearance] setBackgroundImage:nil forState:UIControlStateHighlighted];
}

+ (void)setDefaultTextFieldsAppearance
{
    [[UITextField appearance] setBackground:[UIImage imageNamed:@"clear"]];
    [[UITextField appearance] setBorderStyle:UITextBorderStyleRoundedRect];
}

+ (void)configurateTextFields
{
    [[UISearchBar appearance] setTintColor:[UIColor brownColor]];
    
    [[UITextField appearanceWhenContainedIn:[CCBaseViewController class], nil] setBackground:[[UIImage imageNamed:@"input_field"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    [[UITextField appearance] setBorderStyle:UITextBorderStyleNone];

}

+ (void)configurateNavigationBar
{
    UIImage *navBackgroundImage = [[UIImage imageNamed:@"navigation_bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                UITextAttributeTextColor: [UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1]
     }];
}

+ (void)configurateBarButtons
{
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *barButtonImage = [[UIImage imageNamed:@"action_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                               UITextAttributeTextColor : [UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1]
     } forState:UIControlStateNormal];
    
}

+ (void)setDefaultButtonsAppearance
{
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateNormal];
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateHighlighted];
}

+ (void)configurateButtons
{
    UIImage *customButtonBackground = [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
    
    UIImage *customButtonActiveBackground = [[UIImage imageNamed:@"button_active"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
    
    [[UIButton appearance] setBackgroundImage:customButtonBackground forState:UIControlStateNormal];
    
    [[UIButton appearance] setBackgroundImage:customButtonActiveBackground forState:UIControlStateHighlighted];
    
    [[UILabel appearanceWhenContainedIn:[UIButton class], nil] setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:16]];
    
    [[UILabel appearanceWhenContainedIn:[UIButton class], nil] setTextColor:[UIColor yellowColor]];
    
    [[UIButton appearanceWhenContainedIn:[CCDefaultButtonContainer class], nil] setBackgroundImage:nil forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[CCDefaultButtonContainer class], nil] setBackgroundImage:nil forState:UIControlStateHighlighted];
    [[UILabel appearanceWhenContainedIn:[CCDefaultButtonContainer class], nil] setFont:[UIFont fontWithName:@"Avenir-Oblique" size:16]];
}

+ (void)configurateSegmentController
{
    [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:@"button_active"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:[[UIImage imageNamed:@"separator"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                  UITextAttributeTextColor : [UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1],
                            UITextAttributeTextShadowColor : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0],
     } forState:UIControlStateNormal];
}

+ (void)configurateSwitch
{
    [[UISwitch appearance] setTintColor:[UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1]];
    [[UISwitch appearance] setOnTintColor:[UIColor colorWithRed:0 green:170./255 blue:0 alpha:1]];
}

+ (void)configurateProgressHuds
{
    [SVProgressHUD setShouldHideByTap:YES];
}

@end
