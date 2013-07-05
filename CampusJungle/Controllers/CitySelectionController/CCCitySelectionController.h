//
//  CCCitySelectionScreenViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTableBasedController.h"
#import "CCTransactionWithObject.h"

@interface CCCitySelectionController : CCTableBasedController

@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) id <CCTransactionWithObject> educationTransaction;

@end
