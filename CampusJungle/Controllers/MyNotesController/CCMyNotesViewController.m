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
#import "CCNavigationBarViewHellper.h"

@interface CCMyNotesViewController ()

@property (nonatomic, strong) CCBaseDataProvider *dataProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMyNotesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Notes";
    self.dataProvider = [CCMyNotesDataProvider new];
    [self configTableWithProvider:self.dataProvider cellClass:[CCNoteCell class]];
    self.navigationItem.rightBarButtonItem = [CCNavigationBarViewHellper plusButtonWithTarget:self action:@selector(createNewNote)];
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

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
