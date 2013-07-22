//
//  CCAddGroupViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCTransaction.h"

@class CCClass;

@interface CCAddGroupViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;
- (void)setClassObject:(CCClass *)classObject;

@end
