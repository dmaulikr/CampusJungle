//
//  CCBaseViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import <TestFlightSDK/TestFlight.h>
#import "CCReportPostingService.h"

@interface CCBaseViewController ()<UIAppearanceContainer>

@end

@implementation CCBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TestFlight passCheckpoint: NSStringFromClass(self.class)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
   
    backgroundView.image = [UIImage imageNamed:@"background-568h@2x"];
    
    [self setButtonsTextColorInView:self.view];
    
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [UITapGestureRecognizer new];
    [tapGestureRecognizer addTarget:self action:@selector(viewDidTap)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.tapRecognizer = tapGestureRecognizer;
    self.tapRecognizer.enabled = NO;
}

- (void)viewDidTap
{
    [self.view endEditing:YES];
}

- (void)setButtonsTextColorInView:(UIView *)view
{
    for (UIButton *button in view.subviews) {
        if([button isKindOfClass:[UIButton class]]){
            [button setTitleColor:[UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1] forState:UIControlStateNormal];
        }
        else {
                [self setButtonsTextColorInView:button];
        }
    }
}

- (void)setRightNavigationItemWithTitle:(NSString *)title selector:(SEL)selector
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:selector];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem animated:YES];
}

- (void)setLeftNavigationItemWithTitle:(NSString *)title selector:(SEL)selector
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:selector];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem animated:YES];
}

- (void)postReportOnContent:(id<CCModelTypeProtocol>)content
{
    [CCReportPostingService postReportOnContent:content];
}


@end