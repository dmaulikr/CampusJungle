//
//  CCInitialUserInfoController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransaction.h"

@interface CCInitialUserInfoController : CCViewController

@property (nonatomic, strong) id <CCTransaction> loginTransaction;

- (IBAction)continueButtonDidPressed;

@end
