//
//  CCCollegeSearchControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCCollegeSearchController : CCTableBasedController

@property (nonatomic, strong) id <CCTransaction> createCollegeTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> createEducationTransaction;

@end
