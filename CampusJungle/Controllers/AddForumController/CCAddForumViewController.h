//
//  CCAddForumViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCTransaction.h"

@class CCClass;

@interface CCAddForumViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setClass:(CCClass *)classObject;

@end
