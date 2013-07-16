//
//  CCCollegeSearchControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCCollegeSearchController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransaction> createCollegeTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> createEducationTransaction;

@end
