//
//  CCStateSelectionConroller.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCCommonDataSource.h"
#import "CCTransactionWithObject.h"
#import "CCTableBaseViewController.h"

@interface CCStateSelectionConroller : CCTableBaseViewController <UISearchBarDelegate, CCCellSelectionProtocol>

@property (nonatomic, strong) id <CCTransactionWithObject> citySelectionTransaction;

@end
