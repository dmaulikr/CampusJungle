//
//  CCCreateStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateStuffTransaction.h"
#import "CCStuffCreationController.h"
#import "CCImagesUploadingScreenTransaction.h"

#import "CCDropboxImagesSelectionTransaction.h"


@implementation CCCreateStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);

    CCStuffCreationController *stuffCreationController = [CCStuffCreationController new];
    stuffCreationController.backToListTransaction = self.backToListTransaction;
    CCDropboxImagesSelectionTransaction *dropboxSelection = [CCDropboxImagesSelectionTransaction new];
    dropboxSelection.navigation = self.navigation;
    dropboxSelection.backToListTransaction = self.backToListTransaction;
    
    CCImagesUploadingScreenTransaction *imagesUploadTransaction = [CCImagesUploadingScreenTransaction new];
    
    imagesUploadTransaction.naviation = self.navigation;
    imagesUploadTransaction.backToListTransaction = self.backToListTransaction;
    stuffCreationController.imagesUploadTransaction = imagesUploadTransaction;
    
    stuffCreationController.selectFilesFromDropboxTransaction = dropboxSelection;
    [self.navigation pushViewController:stuffCreationController animated:YES];
    
}

@end
