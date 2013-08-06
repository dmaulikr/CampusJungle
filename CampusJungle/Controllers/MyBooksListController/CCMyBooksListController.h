//
//  CCMyBooksListController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCMyBooksListController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransaction> createBookTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> bookDetailsTransaction;

@end
