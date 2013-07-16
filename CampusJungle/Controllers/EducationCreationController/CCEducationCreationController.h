//
//  CCEducationCreationController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTransactionWithObject.h"

@interface CCEducationCreationController : CCBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> backToUserTransaction;
@property (nonatomic, strong) NSString *collegeName;
@property (nonatomic, strong) NSNumber *collegeID;

@end