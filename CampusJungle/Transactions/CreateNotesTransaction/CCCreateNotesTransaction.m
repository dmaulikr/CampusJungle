//
//  CCCreateNotesTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateNotesTransaction.h"
#import "CCCreateNoteViewController.h"
#import "CCDropboxImagesSelectionTransaction.h"
#import "CCSelectPdfFromDropboxTransaction.h"
#import "CCImagesForNotesUploadingScreenTransaction.h"
#import "CCUploadImagesController.h"

@implementation CCCreateNotesTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.backToListTransaction);
    
    CCCreateNoteViewController *createNotesController = [CCCreateNoteViewController new];
    
    CCImagesForNotesUploadingScreenTransaction *imagesUploadTransaction = [CCImagesForNotesUploadingScreenTransaction new];
    imagesUploadTransaction.uploadImagesControllerClass = [CCUploadImagesController class];
    imagesUploadTransaction.naviation = self.navigation;
    imagesUploadTransaction.backToListTransaction = self.backToListTransaction;
    createNotesController.imagesUploadTransaction = imagesUploadTransaction;
    
    CCDropboxImagesSelectionTransaction *dropboxImagesTransaction = [CCDropboxImagesSelectionTransaction new];
    dropboxImagesTransaction.backToListTransaction = self.backToListTransaction;
    dropboxImagesTransaction.navigation = self.navigation;
    createNotesController.imagesDropboxUploadTransaction = dropboxImagesTransaction;
    
    CCSelectPdfFromDropboxTransaction *dropboxPDFTransaction = [CCSelectPdfFromDropboxTransaction new];
    dropboxPDFTransaction.navigation = self.navigation;
    dropboxPDFTransaction.backToListTransaction = self.backToListTransaction;
    createNotesController.pdfDropboxUploadTransaction = dropboxPDFTransaction;
    
    [self.navigation pushViewController:createNotesController animated:YES];

}

@end