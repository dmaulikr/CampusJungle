//
//  CCViewMarketNotesListTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewMarketNotesListTransaction.h"
#import "CCNoteDetailTransaction.h"
#import "CCListOfNotesInMarketController.h"
#import "CCSelectFiltersTranaction.h"
#import "CCCreateNotesTransaction.h"
#import "CCBackToControllerTransaction.h"

@implementation CCViewMarketNotesListTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCNoteDetailTransaction *noteDetailTransaction = [CCNoteDetailTransaction new];
    noteDetailTransaction.navigation = self.navigation;
    
    CCListOfNotesInMarketController *listOfNotesController = [CCListOfNotesInMarketController new];
    listOfNotesController.noteDetilsTransaction = noteDetailTransaction;
    listOfNotesController.notesProvider = object;
    
    CCSelectFiltersTranaction *selectFilterTransaction = [CCSelectFiltersTranaction new];
    selectFilterTransaction.navigation = self.navigation;
    listOfNotesController.filterTransaction = selectFilterTransaction;
    
    CCCreateNotesTransaction *createNoteTransaction = [CCCreateNotesTransaction new];
    createNoteTransaction.navigation = self.navigation;
    listOfNotesController.addNewNoteTransaction = createNoteTransaction;
    
    CCBackToControllerTransaction *backToListOfNotes = [CCBackToControllerTransaction new];
    backToListOfNotes.navigation = self.navigation;
    backToListOfNotes.targetController = listOfNotesController;
    
    createNoteTransaction.backToListTransaction = backToListOfNotes;
    
    [self.navigation pushViewController:listOfNotesController animated:YES];
}

@end
