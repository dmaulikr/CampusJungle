//
//  CCFilterController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransactionWithObject.h"

@interface CCFilterController : CCTableBasedController

@property (nonatomic, strong) id <CCTransactionWithObject> backToMarketTRansaction;
@property (nonatomic, strong) NSDictionary *oldFilters;

@end
