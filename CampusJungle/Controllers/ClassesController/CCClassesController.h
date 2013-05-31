//
//  CCClassesController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"


@interface CCClassesController : CCTableBasedController
@property (nonatomic, strong) id <CCTransactionWithObject> classTransaction;
@property (nonatomic, strong) id <CCTransaction> addClassTransaction;
@end
