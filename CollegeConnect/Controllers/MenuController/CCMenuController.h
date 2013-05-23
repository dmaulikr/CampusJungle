//
//  CCMenuControllerViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransaction.h"

typedef void (^ViewDidLoadBlock)();

@interface CCMenuController : CCViewController

@property (nonatomic, strong) id <CCTransaction> logoutTransaction;
@property (nonatomic, copy) ViewDidLoadBlock blockOnViewDidAppear;

-(IBAction)logoutButtonPressed;

@end
