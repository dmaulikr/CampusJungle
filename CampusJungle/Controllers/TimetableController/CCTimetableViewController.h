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
#import "CCBackTransactionAfterClassUpdate.h"

@class CCClass;
@protocol CCClassUpdateProtocol;

@interface CCTimetableViewController : CCTableBaseViewController <CCClassUpdateProtocol>

@property (nonatomic, strong) id<CCTransactionWithObject> editClassTransaction;
@property (nonatomic, weak) id<CCClassUpdateProtocol> previousController;

- (void)setClassObject:(CCClass *)classObject;

@end
