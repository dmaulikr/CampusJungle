//
//  CCClassController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//
#import "CCBaseViewController.h"
#import "CCClass.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"
#import "CCTableBaseViewController.h"

@class CCClass;

@interface CCClassController : CCBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> classMarketTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> otherUserProfileTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> locationTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> addLocationTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> addForumTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> forumDetailsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> editClassTransaction;
@property (nonatomic, strong) id <CCTransaction> newsFeedTransaction;

- (id)initWithClass:(CCClass *)classObject;
- (IBAction)classMarketButtonDidPressed;

- (void)updateWithClass:(CCClass *)updatedClass;

@end
