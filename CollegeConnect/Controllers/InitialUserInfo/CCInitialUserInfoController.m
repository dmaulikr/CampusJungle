//
//  CCInitialUserInfoController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInitialUserInfoController.h"

@interface CCInitialUserInfoController ()

@end

@implementation CCInitialUserInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
}

- (IBAction)continueButtonDidPressed
{
    [self.loginTransaction perform];
}

@end
