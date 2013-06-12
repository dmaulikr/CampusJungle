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
#import "CCUserSessionProtocol.h"

@interface CCMyNotesViewController ()

@property (nonatomic, strong) CCBaseDataProvider *dataProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSwession;

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
    if([[[self.ioc_userSwession currentUser] educations] count]){
        [self.addNewNoteTransaction perform];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"You have to join college first"];
    }
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