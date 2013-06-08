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

@interface CCMyNotesViewController ()

@end

@implementation CCMyNotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableWithProvider:[CCMyNotesDataProvider new] cellClass:[CCNoteCell class]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewNote)];
}

- (void)createNewNote
{
    [self.addNewNoteTransaction perform];
}

@end
