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
@protocol CCClassUpdateProtocol;

@interface CCClassController : CCBaseViewController <CCClassUpdateProtocol>


@property (nonatomic, strong) id<CCTransactionWithObject> classMarketTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> otherUserProfileTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> locationTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addLocationTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addForumTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> forumDetailsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> editClassTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> groupDetailsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addGroupTransaction;
@property (nonatomic, strong) id<CCTransaction> newsFeedTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> professorUploadsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> timetableTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> announcementTransaction;

- (id)initWithClass:(CCClass *)classObject;
- (IBAction)classMarketButtonDidPressed;

@end
