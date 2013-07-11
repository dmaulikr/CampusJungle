//
//  CCAddLocationViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCViewController.h"

#import "CCTransactionWithObject.h"

@interface CCAddLocationViewController : CCViewController

@property (nonatomic, strong) id<CCTransactionWithObject> selectGroupToShareTransaction;
@property (nonatomic, strong) id<CCTransactionWithObject> selectUsersToShareTransaction;
@property (nonatomic, strong) id locationToAddobject;

@end
