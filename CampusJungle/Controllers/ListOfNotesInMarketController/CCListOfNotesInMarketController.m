//
//  CCListOfNotesInMarketController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCListOfNotesInMarketController.h"
#import "CCNoteCell.h"

@interface CCListOfNotesInMarketController ()

@end

@implementation CCListOfNotesInMarketController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:self.notesProvider cellClass:[CCNoteCell class]];
    self.title = @"Notes";
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.noteDetilsTransaction performWithObject:cellObject];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
