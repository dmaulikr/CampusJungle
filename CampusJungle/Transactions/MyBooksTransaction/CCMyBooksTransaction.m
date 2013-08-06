//
//  CCMyBooksTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyBooksTransaction.h"
#import "CCMyBooksListController.h"
#import "CCCreateBookTransaction.h"
#import "CCBookDetalsTransaction.h"
#import "CCBackToControllerTransaction.h"

@implementation CCMyBooksTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCMyBooksListController *myBooksController = [CCMyBooksListController new];
    [self.navigation pushViewController:myBooksController animated:YES];
    CCCreateBookTransaction *createBookTransaction = [CCCreateBookTransaction new];
    createBookTransaction.navigation = self.navigation;
    
    CCBackToControllerTransaction *backToListTransaction = [CCBackToControllerTransaction new];
    backToListTransaction.navigation = self.navigation;
    backToListTransaction.targetController = myBooksController;
    
    createBookTransaction.backToListTransaction = backToListTransaction;
    myBooksController.createBookTransaction = createBookTransaction;
    
    CCBookDetalsTransaction *bookDetailsTransaction = [CCBookDetalsTransaction new];
    bookDetailsTransaction.navigation = self.navigation;
    myBooksController.bookDetailsTransaction = bookDetailsTransaction;
}

@end
