//
//  CCInitialUserInfoController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTransaction.h"
#import "CCTableBaseViewController.h"

@interface CCUserProfile : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransaction> logoutTransaction;
@property (nonatomic, strong) id <CCTransaction> addColegeTransaction;
@property (nonatomic, strong) id <CCTransaction> myNotesTransaction;
@property (nonatomic, strong) id <CCTransaction> myStuffTransaction;
@property (nonatomic, strong) NSMutableArray *arrayOfEducations;

- (IBAction)logout;
- (IBAction)avatarDidPressed;
- (IBAction)myNotesButtonDidPressed;
- (IBAction)myStuffButtonDidPreessed;

@end
