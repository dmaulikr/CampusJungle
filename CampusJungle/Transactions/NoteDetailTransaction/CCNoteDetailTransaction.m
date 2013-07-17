//
//  CCNoteDetailTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteDetailTransaction.h"
#import "CCNoteDetailsController.h"
#import "CCViewPDFTransaction.h"
#import "CCBackToNotesListTransaction.h"
#import "CCReviewControllerTransaction.h"

@implementation CCNoteDetailTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCNoteDetailsController *noteDetailsController = [CCNoteDetailsController new];
    noteDetailsController.note = object;
    
    CCViewPDFTransaction *viewNotesAsPDFTRansaction = [CCViewPDFTransaction new];
    viewNotesAsPDFTRansaction.navigation = self.navigation;
    
    noteDetailsController.viewNotesAsPDFTransaction = viewNotesAsPDFTRansaction;
    
    CCBackToNotesListTransaction *backToListTransaction = [CCBackToNotesListTransaction new];
    backToListTransaction.navigation = self.navigation;
    
    CCReviewControllerTransaction *rateControllerTransaction = [CCReviewControllerTransaction new];
    rateControllerTransaction.navigation = self.navigation;
    noteDetailsController.rateTransaction = rateControllerTransaction;
    
    noteDetailsController.backToListTransaction = backToListTransaction;
    
    [self.navigation pushViewController:noteDetailsController animated:YES];
}

@end
