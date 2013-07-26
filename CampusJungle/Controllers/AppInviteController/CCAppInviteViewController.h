//
//  CCAppInviteViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCTransaction.h"

@class CCClass;

@interface CCAppInviteViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setClassObject:(CCClass *)classObject;

@end