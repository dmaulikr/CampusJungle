//
//  CCCitySelectionScreenViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"

@interface CCCitySelectionController : CCTableBaseViewController

@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) id <CCTransactionWithObject> educationTransaction;

@end
