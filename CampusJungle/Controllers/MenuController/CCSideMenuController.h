//
//  CCMenuControllerViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransaction.h"

@interface CCSideMenuController : CCTableBasedController

@property (nonatomic, strong) id <CCTransaction> userProfileTransaction;
@property (nonatomic, strong) id <CCTransaction> classTransaction;

@end
