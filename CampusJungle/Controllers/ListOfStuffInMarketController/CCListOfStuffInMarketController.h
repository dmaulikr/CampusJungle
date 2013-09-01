//
//  CCListOfStuffInMarket.h
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCCellSelectionProtocol.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCListOfStuffInMarketController : CCTableBaseViewController<CCCellSelectionProtocol>

@property (nonatomic, strong) CCBaseDataProvider *tableProvider;
@property (nonatomic, strong) id <CCTransactionWithObject> stuffDetails;
@property (nonatomic, strong) id <CCTransactionWithObject> bookDetails;
@property (nonatomic, strong) id <CCTransaction> createStuffTransaction;
@property (nonatomic, strong) id <CCTransaction> createBookTransaction;

@end
