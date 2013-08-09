//
//  CCAddQuestionTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddQuestionTransaction.h"
#import "CCAddQuestionViewController.h"
#import "CCDropboxImagesSelectionTransaction.h"
#import "CCSelectPdfFromDropboxTransaction.h"
#import "CCImagesUploadingScreenTransaction.h"
#import "CCUploadImagesController.h"
#import "CCBackToControllerTransaction.h"
#import "CCBackTransaction.h"

#import "CCClass.h"
#import "CCGroup.h"

@implementation CCAddQuestionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCImagesUploadingScreenTransaction *imagesUploadTransaction = [CCImagesUploadingScreenTransaction new];
    imagesUploadTransaction.uploadImagesControllerClass = [CCUploadImagesController class];
    imagesUploadTransaction.naviation = self.navigation;
    
    CCDropboxImagesSelectionTransaction *dropboxImagesTransaction = [CCDropboxImagesSelectionTransaction new];
    dropboxImagesTransaction.navigation = self.navigation;

    CCSelectPdfFromDropboxTransaction *dropboxPDFTransaction = [CCSelectPdfFromDropboxTransaction new];
    dropboxPDFTransaction.navigation = self.navigation;
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddQuestionViewController *addQuestionController = [CCAddQuestionViewController new];
    
    CCBackToControllerTransaction *backToUploadTransaction = [CCBackToControllerTransaction new];
    backToUploadTransaction.navigation = self.navigation;
    backToUploadTransaction.targetController = addQuestionController;
    
    addQuestionController.backToSelfController = backToUploadTransaction;
    dropboxImagesTransaction.backToListTransaction = backToUploadTransaction;
    dropboxPDFTransaction.backToListTransaction = backToUploadTransaction;
    
    addQuestionController.imagesDropboxUploadTransaction = dropboxImagesTransaction;
    addQuestionController.imagesUploadTransaction = imagesUploadTransaction;
    addQuestionController.pdfDropboxUploadTransaction = dropboxPDFTransaction;
    addQuestionController.backToListTransaction = backTransaction;
    
    if ([object isKindOfClass:[CCClass class]]) {
        [addQuestionController setClassObject:object];
    }
    else {
        [addQuestionController setGroup:object];
    }
    
    [self.navigation pushViewController:addQuestionController animated:YES];
}

@end
