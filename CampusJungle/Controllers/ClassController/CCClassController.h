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
#import "CCBackTransactionAfterClassUpdate.h"

@class CCClass;
@protocol CCClassUpdateProtocol;

@interface CCClassController : CCBaseViewController <CCClassUpdateProtocol>

@property (nonatomic, strong) id<CCTransactionWithObject> classMarketTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> otherUserProfileTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> locationTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addLocationTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addQuestionTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> questionDetailsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> editClassTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> groupDetailsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addGroupTransaction;
@property (nonatomic, strong) id<CCTransaction> newsFeedTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> professorUploadsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> timetableTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> announcementTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> voteScreenTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> voteResultTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> sendInviteTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> couponsTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> viewPdfAttachmentTransaction;

- (id)initWithClass:(CCClass *)classObject;

@end
