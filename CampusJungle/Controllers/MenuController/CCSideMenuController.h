//
//  CCMenuControllerViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCSideMenuController : CCTableBasedController

@property (nonatomic, strong) id <CCTransaction> userProfileTransaction;
@property (nonatomic, strong) id <CCTransaction> classesTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> classTransaction;
@property (nonatomic, strong) id <CCTransaction> marketTransaction;

@end
