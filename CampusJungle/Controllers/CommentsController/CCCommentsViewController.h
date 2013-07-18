//
//  CCCommentsViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"

@class CCAnswer;

@interface CCCommentsViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransactionWithObject> addCommentTransaction;

- (void)setAnswer:(CCAnswer *)answer;

@end
