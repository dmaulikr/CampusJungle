//
//  CCSingUPControllerViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCViewController.h"
#import "CCTransaction.h"

@interface CCSignUPController : CCViewController

@property (nonatomic, strong) id <CCTransaction> initialUserProfileTransaction;

@end
