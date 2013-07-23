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
#import "CCNoteDetailTransaction.h"
#import "CCBackToControllerTransaction.h"

@implementation CCMyNotesTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyNotesViewController *myNotesController = [CCMyNotesViewController new];
    
    CCCreateNotesTransaction *createNoteTransaction = [CCCreateNotesTransaction new];
    createNoteTransaction.navigation = self.navigation;
    myNotesController.addNewNoteTransaction = createNoteTransaction;
    
    CCBackToControllerTransaction *backToListOfNotes = [CCBackToControllerTransaction new];
    backToListOfNotes.navigation = self.navigation;
    backToListOfNotes.targetController = myNotesController;
    
    createNoteTransaction.backToListTransaction = backToListOfNotes;
    
    CCNoteDetailTransaction *viewNotesTransaction = [CCNoteDetailTransaction new];
    viewNotesTransaction.navigation = self.navigation;
    myNotesController.viewNoteTransaction = viewNotesTransaction;
    
    [self.navigation pushViewController:myNotesController animated:YES];
}

@end
