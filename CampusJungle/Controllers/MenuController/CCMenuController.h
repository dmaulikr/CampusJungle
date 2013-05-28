//
//  CCMenuControllerViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransaction.h"

@interface CCMenuController : CCViewController

@property (nonatomic, strong) id <CCTransaction> userProfileTransaction;
@property (nonatomic, strong) UINavigationController *navigation;

-(IBAction)logoutButtonPressed;

@end
