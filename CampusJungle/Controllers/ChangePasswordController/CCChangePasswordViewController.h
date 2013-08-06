//
//  CCChangePasswordViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCTransaction.h"

@interface CCChangePasswordViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;

@end
