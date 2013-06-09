//
//  CCMyNotesViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyNotesViewController.h"
#import "CCNoteCell.h"
#import "CCMyNotesDataProvider.h"
#import "CCNote.h"
#import "CCStandardErrorHandler.h"

@interface CCMyNotesViewController ()

@property (nonatomic, strong) CCBaseDataProvider *dataProvider;

@end

@implementation CCMyNotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataProvider = [CCMyNotesDataProvider new];
    [self configTableWithProvider:self.dataProvider cellClass:[CCNoteCell class]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewNote)];
}

- (void)createNewNote
{
    [self.addNewNoteTransaction perform];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    CCNote *note = cellObject;
    if(note.link.length){
        [self.viewNoteTransaction performWithObject:cellObject];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Note not ready for review at the moment."];
    }
}

@end
