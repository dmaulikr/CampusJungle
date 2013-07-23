//
//  CCEditGroupViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCTransaction.h"

@class CCGroup;

@protocol CCEditGroupDelegate <NSObject>

- (void)updateWithGroup:(CCGroup *)group;

@end

@interface CCEditGroupViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;
@property (nonatomic, strong) id<CCTransaction> backToClassDetailsTransaction;

- (void)setGroup:(CCGroup *)group;
- (void)setDelegate:(id<CCEditGroupDelegate>)delegate;

@end
