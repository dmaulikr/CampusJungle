//
//  CCMyStuffController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCCellSelectionProtocol.h"

@interface CCMyStuffController : CCTableBaseViewController <CCCellSelectionProtocol>

@property (nonatomic, strong) id <CCTransaction> createStuffTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> stuffDetailsTransaction;

@end
