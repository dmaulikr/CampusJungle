//
//  CCListOfNotesInMarketController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCBaseDataProvider.h"
#import "CCTransactionWithObject.h"

@interface CCListOfNotesInMarketController : CCTableBasedController

@property (nonatomic, strong) CCBaseDataProvider *notesProvider;
@property (nonatomic, strong) id <CCTransactionWithObject> noteDetilsTransaction;

@end
