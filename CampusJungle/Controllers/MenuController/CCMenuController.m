//
//  CCMenuControllerViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMenuController.h"

@interface CCMenuController ()

@end

@implementation CCMenuController

-(IBAction)logoutButtonPressed
{
    [self.userProfileTransaction perform];
}

@end