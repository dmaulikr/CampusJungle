//
//  CCStateSelectionConroller.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCCommonDataSource.h"
#import "CCTransactionWithObject.h"
#import "CCTableBasedController.h"

@interface CCStateSelectionConroller : CCTableBasedController <UISearchBarDelegate, CellSelectionProtocol>

@property (nonatomic, strong) id <CCTransactionWithObject> citySelectionTransaction;

@end
