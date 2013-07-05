//
//  CCCollegeSelectionController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransactionWithObject.h"

@interface CCCollegeSelectionController : CCTableBasedController

@property (nonatomic, strong) NSNumber *cityID;
@property (nonatomic, strong) id <CCTransactionWithObject> educationTransaction;

@end
