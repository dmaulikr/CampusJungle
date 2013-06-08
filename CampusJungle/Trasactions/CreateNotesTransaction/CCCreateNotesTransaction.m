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

@implementation CCCreateNotesTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCCreateNoteViewController *createNotesController = [CCCreateNoteViewController new];
    
    CCDropboxImagesSelectionTransaction *dropboxImagesTransaction = [CCDropboxImagesSelectionTransaction new];
    dropboxImagesTransaction.navigation = self.navigation;
    createNotesController.imagesDropboxUploadTransaction = dropboxImagesTransaction;
    
    [self.navigation pushViewController:createNotesController animated:YES];

}

@end
