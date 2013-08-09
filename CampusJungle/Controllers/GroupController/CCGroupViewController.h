//
//  CCGroupViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCTransactionWithObject.h"
#import "CCBackTransaction.h"

@class CCGroup;

@interface CCGroupViewController : CCBaseViewController

@property(nonatomic, strong) id <CCTransactionWithObject> otherUserProfileTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> locationTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> addLocationTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> addQuestionTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> questionDetailsTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> editGroupTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> groupMessageTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> messageDetailsTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> sendGroupInviteTransaction;
@property(nonatomic, strong) id <CCTransactionWithObject> viewPdfAttachmentTransaction;
@property(nonatomic, strong) id <CCTransaction> backTransaction;

- (void)setGroup:(CCGroup *)group;

@end
