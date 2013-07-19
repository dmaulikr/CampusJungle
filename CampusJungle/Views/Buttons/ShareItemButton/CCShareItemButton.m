//
//  CCShareItemButton.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCShareItemButton.h"

@interface CCShareItemButton ()

@property (nonatomic, copy) ShareItemButtonActionBlock actionBlock;

@end

@implementation CCShareItemButton

+ (CCShareItemButton *)buttonWithTitle:(NSString *)title actionBlock:(ShareItemButtonActionBlock)actionBlock
{
    CCShareItemButton *button = [CCShareItemButton new];
    button.actionBlock = actionBlock;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:BASE_TEXT_COLOR forState:UIControlStateNormal];
    [button addTarget:button action:@selector(performTransaction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark -
#pragma mark Actions
- (void)performTransaction:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
