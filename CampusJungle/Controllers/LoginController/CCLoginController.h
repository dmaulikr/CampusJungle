//
//  CCLoginController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTransaction.h"

@interface CCLoginController : CCBaseViewController

@property (nonatomic, strong) id <CCTransaction> loginTransaction;
@property (nonatomic, strong) id <CCTransaction> userProfileTransaction;


- (IBAction)loginButtonDidPressed;

@end
