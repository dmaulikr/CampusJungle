//
//  CCMarketPlaceController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransactionWithObject.h"

@interface CCMarketPlaceController : CCViewController

@property (nonatomic, strong) id <CCTransactionWithObject> filtersScreenTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> noteDetailsTransaction;

@property (nonatomic, strong) NSDictionary *filters;

- (void)update;

@end
