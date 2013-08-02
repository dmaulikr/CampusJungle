//
//  CCBaseViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//
#import "CCReportDelegateProtocol.h"
@protocol CCModelTypeProtocol;

@interface CCBaseViewController : UIViewController <CCReportDelegateProtocol>

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

- (void)setButtonsTextColorInView:(UIView *)view;
- (void)setRightNavigationItemWithTitle:(NSString*)title selector:(SEL)selector;
- (void)setLeftNavigationItemWithTitle:(NSString *)title selector:(SEL)selector;
- (void)postReportOnContent:(id<CCModelTypeProtocol>)content;

@end