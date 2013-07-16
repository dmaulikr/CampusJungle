//
//  CCMyNotesViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCMyNotesViewController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransaction> addNewNoteTransaction;
@property (nonatomic ,strong) id <CCTransactionWithObject> viewNoteTransaction;

@end
