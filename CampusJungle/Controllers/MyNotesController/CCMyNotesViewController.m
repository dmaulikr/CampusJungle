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
#import "CCNavigationBarViewHelper.h"
#import "CCPurchasedNotesDataProvider.h"
#define UploadedState 0
#define PurchasedState 1

@interface CCMyNotesViewController ()

@property (nonatomic, strong) CCBaseDataProvider *dataProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

- (IBAction)segmentedControlDidChangeValue:(UISegmentedControl *)control;

@end

@implementation CCMyNotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Notes";
    [self setUploadedConfiguration];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHelper plusButtonWithTarget:self action:@selector(createNewNote)];
}

- (void)createNewNote
{
    if([[[self.ioc_userSession currentUser] educations] count]){
        [self.addNewNoteTransaction perform];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:@"You have to join college first"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCNote class]]){
        [self.viewNoteTransaction performWithObject:cellObject];
    }
}

- (IBAction)segmentedControlDidChangeValue:(UISegmentedControl *)control
{
    switch (control.selectedSegmentIndex) {
        case UploadedState :{
            [self setUploadedConfiguration];
        } break;
        case PurchasedState:{
            [self setPurchasedConfiguration];
        } break;

    }
}

- (void)setUploadedConfiguration
{
    self.dataProvider = [CCMyNotesDataProvider new];
    [self configTableWithProvider:self.dataProvider cellClass:[CCNoteCell class]];
}

- (void)setPurchasedConfiguration
{
    self.dataProvider = [CCPurchasedNotesDataProvider new];
    [self configTableWithProvider:self.dataProvider cellClass:[CCNoteCell class]];
}


- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
