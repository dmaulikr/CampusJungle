//
//  CCAddCommentViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCTransaction.h"

@class CCAnswer;

@interface CCAddCommentViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setAnswer:(CCAnswer *)answer;

@end
