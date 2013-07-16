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

@interface CCListOfNotesInMarketController : CCTableBaseViewController

@property (nonatomic, strong) CCBaseDataProvider *notesProvider;
@property (nonatomic, strong) id <CCTransactionWithObject> noteDetilsTransaction;

@end
