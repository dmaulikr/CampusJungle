//
//  CCLoginController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransaction.h"

@interface CCLoginController : CCViewController

@property (nonatomic, strong) id <CCTransaction> loginTransaction;

- (IBAction)loginButtonDidPressed;

@end
