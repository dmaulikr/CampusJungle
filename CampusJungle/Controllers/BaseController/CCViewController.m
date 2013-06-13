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
     [TestFlight passCheckpoint:self.title];
}

@end