//
//  CCQuestionsViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"

@class CCForum;

@interface CCQuestionsViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransactionWithObject> addQuestionTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> answersTransaction;

- (void)setForum:(CCForum *)forum;

@end
