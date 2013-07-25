//
//  CCGroupInviteViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTableBaseViewController.h"
#import "CCTransaction.h"

@class CCGroup;

@interface CCGroupInviteViewController : CCTableBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

- (void)setGroup:(CCGroup *)group;

@end
