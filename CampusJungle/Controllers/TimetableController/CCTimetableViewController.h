//
//  CCTimetableViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"

#import "CCTransactionWithObject.h"

@class CCClass;

@interface CCTimetableViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransactionWithObject> editClassTransaction;

- (void)setClassObject:(CCClass *)classObject;

@end
