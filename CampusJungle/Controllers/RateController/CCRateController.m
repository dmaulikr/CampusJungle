//
//  CCRateControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCRateController.h"
#import "DYRateView.h"

@interface CCRateController ()

@property (nonatomic, strong) DYRateView *rateView;

@end

@implementation CCRateController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.view addSubview:self.rateView];
    self.rateView.editable = YES;
    self.rateView.alignment = RateViewAlignmentCenter;
    
}

@end
