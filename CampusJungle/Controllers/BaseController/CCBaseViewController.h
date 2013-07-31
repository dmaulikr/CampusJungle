//
//  CCBaseViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

@protocol CCModelIdAccessorProtocol;

@interface CCBaseViewController : UIViewController

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

- (void)setButtonsTextColorInView:(UIView *)view;
- (void)setRightNavigationItemWithTitle:(NSString*)title selector:(SEL)selector;
- (void)setLeftNavigationItemWithTitle:(NSString *)title selector:(SEL)selector;
- (void)postReportOnContent:(id<CCModelIdAccessorProtocol>)content;

@end