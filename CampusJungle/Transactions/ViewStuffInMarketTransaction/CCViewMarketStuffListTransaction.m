//
//  CCViewMarketStuffListTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewMarketStuffListTransaction.h"
#import "CCListOfStuffInMarketController.h"
#import "CCStuffDetailsTransaction.h"
#import "CCBookDetalsTransaction.h"
#import "CCCreateStuffTransaction.h"
#import "CCBackToControllerTransaction.h"
#import "CCCreateBookTransaction.h"

@implementation CCViewMarketStuffListTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);

    CCListOfStuffInMarketController *listOfNotesController = [CCListOfStuffInMarketController new];
    listOfNotesController.tableProvider = object;
    
    CCStuffDetailsTransaction *stuffDetail = [CCStuffDetailsTransaction new];
    stuffDetail.navigation = self.navigation;
    
    CCBookDetalsTransaction *bookDetailsTransaction = [CCBookDetalsTransaction new];
    bookDetailsTransaction.navigation = self.navigation;
    listOfNotesController.bookDetails = bookDetailsTransaction;
    //
    CCCreateStuffTransaction *creationStuffTransaction = [CCCreateStuffTransaction new];
    creationStuffTransaction.navigation = self.navigation;
    listOfNotesController.createStuffTransaction = creationStuffTransaction;
    
    
    CCBackToControllerTransaction *backToListTransaction = [CCBackToControllerTransaction new];
    backToListTransaction.navigation = self.navigation;
    backToListTransaction.targetController = listOfNotesController;
    
    creationStuffTransaction.backToListTransaction = backToListTransaction;
    //
    CCCreateBookTransaction *createBookTransaction = [CCCreateBookTransaction new];
    createBookTransaction.navigation = self.navigation;
    createBookTransaction.backToListTransaction = backToListTransaction;
    listOfNotesController.createBookTransaction = createBookTransaction;

    //
    listOfNotesController.stuffDetails = stuffDetail;
    [self.navigation pushViewController:listOfNotesController animated:YES];
    
}

@end
