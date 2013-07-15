//
//  CCAddForumViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCViewController.h"
#import "CCTransaction.h"

@class CCClass;

@interface CCAddForumViewController : CCViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setClass:(CCClass *)classObject;

@end
