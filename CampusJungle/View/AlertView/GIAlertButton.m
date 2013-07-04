//
//  GIAlertButton.m
//  GiftIt
//
//  Created by Vlad Korzun on 20.03.13.
//  Copyright (c) 2013 Julia Petryshena. All rights reserved.
//

#import "GIAlertButton.h"

@implementation GIAlertButton

+(GIAlertButton*)buttonWithTitle:(NSString *)title action:(Action)actionOnClick
{
    GIAlertButton * newButton = [GIAlertButton baseButtonCreationTitle:title action:actionOnClick];
    [newButton setBackgroundImage:[GIAlertButton resizableImageWithName:@"button_active"] forState:UIControlStateNormal];
    [newButton setBackgroundImage:[GIAlertButton resizableImageWithName:@"button"] forState:UIControlStateHighlighted];
    return newButton;
}

+(GIAlertButton*)actionSheetButtonWithTitle:(NSString *)title action:(Action)actionOnClick
{
    GIAlertButton * newButton = [GIAlertButton baseButtonCreationTitle:title action:actionOnClick];
    [newButton setBackgroundImage:[GIAlertButton resizableImageWithName:@"actionSheetButton"] forState:UIControlStateNormal];
    return newButton;
}

+(GIAlertButton*)cancelButtonWithTitle:(NSString *)title action:(Action)actionOnClick
{
    GIAlertButton * newButton = [GIAlertButton baseButtonCreationTitle:title action:actionOnClick];
    [newButton setBackgroundImage:[GIAlertButton resizableImageWithName:@"button"] forState:UIControlStateNormal];
    [newButton setBackgroundImage:[GIAlertButton resizableImageWithName:@"button_active"] forState:UIControlStateHighlighted];
    newButton.isCancel = YES;
    return newButton;
}

+(GIAlertButton*)baseButtonCreationTitle:(NSString*)title action:(Action)actionOnClick
{
    GIAlertButton * newButton = [GIAlertButton new];
    
    newButton.actionOnClick = actionOnClick;
    [newButton addTarget:newButton action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [newButton setTitle:title forState:UIControlStateNormal];
    newButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [newButton setTitleColor: [UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1] forState:UIControlStateNormal];
    [newButton setTitleColor: [UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1] forState:UIControlStateHighlighted];
    return newButton;
}

+(UIImage*)resizableImageWithName:(NSString*)name
{
    UIImage* buttonImage = [UIImage imageNamed:name];
    return [buttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

-(void)buttonDidClick:(GIAlertButton*)selector
{
    if (selector.actionOnClick) {
        selector.actionOnClick();
    }
    [self.containingObject remove];
}

@end
