//
//  CCListOfNotesInMarketController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCBaseDataProvider.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCListOfNotesInMarketController : CCTableBaseViewController

@property (nonatomic, strong) CCBaseDataProvider *notesProvider;
@property (nonatomic, strong) id <CCTransactionWithObject> noteDetilsTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> filterTransaction;
@property (nonatomic, strong) id <CCTransaction> addNewNoteTransaction;

@end
