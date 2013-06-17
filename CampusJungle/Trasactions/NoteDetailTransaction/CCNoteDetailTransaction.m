//
//  CCNoteDetailTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteDetailTransaction.h"
#import "CCNoteDetailsController.h"
#import "CCViewPDFNotesTransaction.h"

@implementation CCNoteDetailTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCNoteDetailsController *noteDetailsController = [CCNoteDetailsController new];
    noteDetailsController.note = object;
    
    CCViewPDFNotesTransaction *viewNotesAsPDFTRansaction = [CCViewPDFNotesTransaction new];
    viewNotesAsPDFTRansaction.navigation = self.navigation;
    
    noteDetailsController.viewNotesAsPDFTransaction = viewNotesAsPDFTRansaction;
    
    [self.navigation pushViewController:noteDetailsController animated:YES];
    
}

@end
