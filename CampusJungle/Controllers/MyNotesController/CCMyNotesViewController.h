//
//  CCMyNotesViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransaction.h"

@interface CCMyNotesViewController : CCTableBasedController

@property (nonatomic, strong) id <CCTransaction> addNewNoteTransaction;

@end
