//
//  CCClassController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//
#import "CCViewController.h"
#import "CCClass.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"
#import "CCTableBasedController.h"

@class CCClass;

@interface CCClassController : CCViewController

@property (nonatomic, strong) id <CCTransactionWithObject> classMarketTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> otherUserProfileTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> locationTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> addLocationTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> addForumTransaction;
@property (nonatomic, strong) id <CCTransaction> newsFeedTransaction;

- (id)initWithClass:(CCClass *)classObject;
- (IBAction)classMarketButtonDidPressed;

@end
