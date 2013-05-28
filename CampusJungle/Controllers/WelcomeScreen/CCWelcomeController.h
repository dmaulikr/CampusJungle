//
//  CCLoginController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCViewController.h"
#import "CCTransaction.h"

@interface CCWelcomeController : CCViewController

@property (nonatomic, strong) id <CCTransaction> loginTransaction;
@property (nonatomic, strong) id <CCTransaction> signUpTransaction;
@property (nonatomic, strong) id <CCTransaction> loginScreenTransaction;
@property (nonatomic, strong) id <CCTransaction> initialUserInfoTransaction;

- (IBAction)facebookLoginButtonDidPressed;

- (IBAction)emailLoginButtonDidPressed;

- (IBAction)emailSignUPButtonDidPressed;

- (IBAction)twitterLoginButtonPressed;
@end