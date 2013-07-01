//
//  CCViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

@interface CCViewController : UIViewController

@property (nonatomic, strong) UITapGestureRecognizer *tapRcognizer;

- (void)setButtonsTextColorInView:(UIView *)view;
- (void)setRightNavigationItemWithTitle:(NSString*)title selector:(SEL)selector;
- (void)setLeftNavigationItemWithTitle:(NSString *)title selector:(SEL)selector;

@end