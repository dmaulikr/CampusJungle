//
//  CCAddAnswerTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddAnswerTransaction.h"
#import "CCBackTransaction.h"
#import "CCAddAnswerViewController.h"
#import "CCImagesUploadingScreenTransaction.h"
#import "CCUploadImagesController.h"
#import "CCDropboxImagesSelectionTransaction.h"
#import "CCSelectPdfFromDropboxTransaction.h"
#import "CCBackToControllerTransaction.h"

@implementation CCAddAnswerTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddAnswerViewController *addAnswerController = [CCAddAnswerViewController new];
    [addAnswerController setQuestion:object];
    addAnswerController.backTransaction = backTransaction;
    
    CCImagesUploadingScreenTransaction *imagesUploadTransaction = [CCImagesUploadingScreenTransaction new];
    imagesUploadTransaction.uploadImagesControllerClass = [CCUploadImagesController class];
    imagesUploadTransaction.naviation = self.navigation;
    
    CCDropboxImagesSelectionTransaction *dropboxImagesTransaction = [CCDropboxImagesSelectionTransaction new];
    dropboxImagesTransaction.navigation = self.navigation;
    
    CCSelectPdfFromDropboxTransaction *dropboxPDFTransaction = [CCSelectPdfFromDropboxTransaction new];
    dropboxPDFTransaction.navigation = self.navigation;
    
    CCBackToControllerTransaction *backToUploadTransaction = [CCBackToControllerTransaction new];
    backToUploadTransaction.navigation = self.navigation;
    backToUploadTransaction.targetController = addAnswerController;
    
    addAnswerController.backToSelfController = backToUploadTransaction;
    addAnswerController.imagesUploadTransaction = imagesUploadTransaction;
    addAnswerController.imagesDropboxUploadTransaction = dropboxImagesTransaction;
    addAnswerController.pdfDropboxUploadTransaction = dropboxPDFTransaction;
    
    [self.navigation pushViewController:addAnswerController animated:YES];
}

@end
