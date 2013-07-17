//
//  CCAnswersViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"

@class CCQuestion;

@interface CCAnswersViewController : CCTableBaseViewController

- (void)setQuestion:(CCQuestion *)question;

@end
