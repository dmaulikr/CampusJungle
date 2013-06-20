//
//  CCCreateStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateStuffTransaction.h"
#import "CCStuffCreationController.h"
#import "CCDropboxImagesFileSelectionForStuffTransaction.h"
#import "CCImagesForNotesUploadingScreenTransaction.h"
#import "CCUploadImageForStuffController.h"

@implementation CCCreateStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);

    CCStuffCreationController *stuffCreationController = [CCStuffCreationController new];
    
    CCDropboxImagesFileSelectionForStuffTransaction *dropboxSelection = [CCDropboxImagesFileSelectionForStuffTransaction new];
    dropboxSelection.navigation = self.navigation;
    dropboxSelection.backToListTransaction = self.backToListTransaction;
    
    CCImagesForNotesUploadingScreenTransaction *imagesUploadTransaction = [CCImagesForNotesUploadingScreenTransaction new];
    imagesUploadTransaction.uploadImagesControllerClass = [CCUploadImageForStuffController class];
    imagesUploadTransaction.naviation = self.navigation;
    imagesUploadTransaction.backToListTransaction = self.backToListTransaction;
    stuffCreationController.imagesUploadTransaction = imagesUploadTransaction;
    
    stuffCreationController.selectFilesFromDropboxTransaction = dropboxSelection;
    [self.navigation pushViewController:stuffCreationController animated:YES];
    
}

@end
