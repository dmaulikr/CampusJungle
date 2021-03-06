//
//  CCClassesOfCollegeController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCClassesOfCollegeController : CCTableBaseViewController

- (id)initWithCollegeID:(NSString*)collegeID;

@property (nonatomic, strong) id <CCTransactionWithObject> addNewClassTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> classAddedTransaction;


@end
