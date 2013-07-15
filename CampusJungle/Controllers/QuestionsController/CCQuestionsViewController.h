//
//  CCQuestionsViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBasedController.h"
#import "CCTransactionWithObject.h"

@class CCForum;

@interface CCQuestionsViewController : CCTableBasedController

@property (nonatomic, strong) id<CCTransactionWithObject> addQuestionTransaction;

- (void)setForum:(CCForum *)forum;

@end
