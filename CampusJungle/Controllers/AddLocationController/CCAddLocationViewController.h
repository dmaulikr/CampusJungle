//
//  CCAddLocationViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"

#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCAddLocationViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransactionWithObject> selectGroupToShareTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> selectUsersToShareTransaction;
@property (nonatomic, strong) id<CCTransaction> backTransaction;
@property (nonatomic, strong) id locationToAddObject;

@end
