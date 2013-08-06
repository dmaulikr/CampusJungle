//
//  CCCreateBookTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateBookTransaction.h"
#import "CCAddBookViewController.h"
#import "CCBackToControllerTransaction.h"
#import "CCDropboxImagesSelectionTransaction.h"
#import "CCImagesUploadingScreenTransaction.h"

@implementation CCCreateBookTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    
    CCAddBookViewController *bookCreationController = [CCAddBookViewController new];
    bookCreationController.backToListTransaction = self.backToListTransaction;
    
    CCBackToControllerTransaction *backToControllerTransaction = [CCBackToControllerTransaction new];
    backToControllerTransaction.navigation = self.navigation;
    backToControllerTransaction.targetController = bookCreationController;
    bookCreationController.backToSlefTransaction = backToControllerTransaction;
    
    CCDropboxImagesSelectionTransaction *dropboxSelection = [CCDropboxImagesSelectionTransaction new];
    
    dropboxSelection.navigation = self.navigation;
    dropboxSelection.backToListTransaction = backToControllerTransaction;
    
    CCImagesUploadingScreenTransaction *imagesUploadTransaction = [CCImagesUploadingScreenTransaction new];
    
    imagesUploadTransaction.naviation = self.navigation;
    imagesUploadTransaction.backToListTransaction = self.backToListTransaction;
    bookCreationController.imagesUploadTransaction = imagesUploadTransaction;
    
    bookCreationController.selectFilesFromDropboxTransaction = dropboxSelection;
    [self.navigation pushViewController:bookCreationController animated:YES];
}

@end
