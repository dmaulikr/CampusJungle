//
//  CCCollegesListController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"


@interface CCCollegesListController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> classesOfcurrentCollegeTransaction;

- initWithArray:(NSArray*)educations;

@end
