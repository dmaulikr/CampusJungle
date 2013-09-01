//
//  CCMenuControllerViewController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCSideMenuController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransaction> userProfileTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> classesOfCollegeTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> classTransaction;
@property (nonatomic, strong) id <CCTransaction> marketTransaction;
@property (nonatomic, strong) id <CCTransaction> inboxTransaction;
@property (nonatomic, strong) id <CCTransaction> notesTransaction;
@property (nonatomic, strong) id <CCTransaction> booksTransaction;
@property (nonatomic, strong) id <CCTransaction> collegeMarketTransaction;
@property (nonatomic, strong) id <CCTransaction> earnTransaction;

@end
