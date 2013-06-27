//
//  CCViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import <TestFlightSDK/TestFlight.h>

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TestFlight passCheckpoint: NSStringFromClass(self.class)];
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
   
    backgroundView.image = [UIImage imageNamed:@"background-568h@2x"];
    
    [self setButtonsTextCollorInView:self.view];
    
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}

- (void)setButtonsTextCollorInView:(UIView *)view
{
    for(UIButton *button in view.subviews){
        if([button isKindOfClass:[UIButton class]]){
            [button setTitleColor:[UIColor colorWithRed:240./255 green:218./255 blue:161./255 alpha:1] forState:UIControlStateNormal];
        } else {
            [self setButtonsTextCollorInView:button];
        }
    }
}

@end