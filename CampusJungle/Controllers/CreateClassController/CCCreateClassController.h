//
//  CCCreateClassController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransactionWithObject.h"

@interface CCCreateClassController : CCViewController

@property (nonatomic, strong) id <CCTransactionWithObject> classAddedTransaction;

- (id)initWithCollegeID:(NSString *)collegeId;

@end
