//
//  CCInitialUserInfoController.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransaction.h"
#import "CCTableBasedController.h"

@interface CCUserProfile : CCTableBasedController

@property (nonatomic, strong) id <CCTransaction> logoutTransaction;
@property (nonatomic, strong) id <CCTransaction> addColegeTransaction;

@property (nonatomic, strong) NSMutableArray *arrayOfColleges;

- (IBAction)logout;


@end
