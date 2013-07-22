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

@property (nonatomic, strong) id<CCTransactionWithObject> otherUserProfileTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> locationTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addLocationTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> addForumTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> forumDetailsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> editGroupTransaction;
@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setGroup:(CCGroup *)group;

@end