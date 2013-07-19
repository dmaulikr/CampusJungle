//
//  CCAddProfessorUploadsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddProfessorUploadsTransaction.h"
#import "CCAddProfessorUploadsController.h"
#import "CCImagesUploadingScreenTransaction.h"
#import "CCUploadImagesController.h"
#import "CCDropboxImagesSelectionTransaction.h"
#import "CCSelectPdfFromDropboxTransaction.h"



@implementation CCAddProfessorUploadsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCAddProfessorUploadsController *addProfessorUploadsController = [CCAddProfessorUploadsController new];
    
    addProfessorUploadsController.currentClass = object;
    
    CCImagesUploadingScreenTransaction *imagesUploadTransaction = [CCImagesUploadingScreenTransaction new];
    imagesUploadTransaction.uploadImagesControllerClass = [CCUploadImagesController class];
    imagesUploadTransaction.naviation = self.navigation;
    
    CCDropboxImagesSelectionTransaction *dropboxImagesTransaction = [CCDropboxImagesSelectionTransaction new];
    dropboxImagesTransaction.navigation = self.navigation;
    
    CCSelectPdfFromDropboxTransaction *dropboxPDFTransaction = [CCSelectPdfFromDropboxTransaction new];
    dropboxPDFTransaction.navigation = self.navigation;
    
    addProfessorUploadsController.imagesDropboxUploadTransaction = dropboxImagesTransaction;
    addProfessorUploadsController.pdfDropboxUploadTransaction = dropboxPDFTransaction;
    addProfessorUploadsController.imagesUploadTransaction = imagesUploadTransaction;
    addProfessorUploadsController.backToListTransaction = self.backToListTransaction;
    
    [self.navigation pushViewController:addProfessorUploadsController animated:YES];
}

@end
