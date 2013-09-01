//
//  CCListOfNotesInMarketController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCListOfNotesInMarketController.h"
#import "CCNoteCell.h"
#import "CCMarketNotesProvider.h"
#import "CCNavigationBarViewHelper.h"

@interface CCListOfNotesInMarketController ()
- (IBAction)filters;
@end

@implementation CCListOfNotesInMarketController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:self.notesProvider cellClass:[CCNoteCell class]];
    self.title = @"Notes";
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(plus)];
}

- (IBAction)filters
{    
    [self.filterTransaction performWithObject:self.dataSource.dataProvider];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.noteDetilsTransaction performWithObject:cellObject];
}

- (void) plus
{
    [self.addNewNoteTransaction perform];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)update
{
    [self.dataSource.dataProvider loadItems];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.notesProvider loadItems];
}

@end
