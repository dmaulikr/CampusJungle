//
//  CCMyNotesTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyNotesTransaction.h"
#import "CCMyNotesViewController.h"
#import "CCCreateNotesTransaction.h"
#import "CCViewNotesTransaction.h"
#import "CCBackToListOfNotesTransaction.h"

@implementation CCMyNotesTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyNotesViewController *myNotesController = [CCMyNotesViewController new];
    
    CCCreateNotesTransaction *createNoteTransaction = [CCCreateNotesTransaction new];
    createNoteTransaction.navigation = self.navigation;
    myNotesController.addNewNoteTransaction = createNoteTransaction;
    
    CCBackToListOfNotesTransaction *backToListOfNotes = [CCBackToListOfNotesTransaction new];
    backToListOfNotes.navigation = self.navigation;
    backToListOfNotes.listController = myNotesController;
    
    createNoteTransaction.backToListTransaction = backToListOfNotes;
    
    CCViewNotesTransaction *viewNotesTransaction = [CCViewNotesTransaction new];
    viewNotesTransaction.navigation = self.navigation;
    myNotesController.viewNoteTransaction = viewNotesTransaction;
    
    [self.navigation pushViewController:myNotesController animated:YES];
}

@end