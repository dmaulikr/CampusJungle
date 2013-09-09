//
//  CCAnswersViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"

@class CCQuestion;

@interface CCAnswersViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransactionWithObject> addAnswerTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> showCommentsTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> viewAttacmentTransaction;

- (void)setQuestion:(CCQuestion *)question;

@end
