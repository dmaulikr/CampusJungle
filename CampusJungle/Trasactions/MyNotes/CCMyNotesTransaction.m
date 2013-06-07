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

@implementation CCMyNotesTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyNotesViewController *myNotesController = [CCMyNotesViewController new];
    CCCreateNotesTransaction *createNoteTransaction = [CCCreateNotesTransaction new];
    createNoteTransaction.navigation = self.navigation;
    myNotesController.addNewNoteTransaction = createNoteTransaction;
    [self.navigation pushViewController:myNotesController animated:YES];
}

@end
