//
//  CCAddAnswerViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCBackTransaction.h"

@class CCQuestion;

@interface CCAddAnswerViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setQuestion:(CCQuestion *)question;

@end
