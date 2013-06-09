//
//  CCDropboxFileSystemTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxImagesFileSystemTransaction.h"
#import "CCDropboxImagesSelectionViewController.h"

@implementation CCDropboxImagesFileSystemTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.backToListTransaction);
    NSDictionary *sendedObject = object;
    CCDropboxImagesFileSystemTransaction *fileSystemTransaction = [self fileSystemTransaction];
    fileSystemTransaction.navigation = self.navigation;
    fileSystemTransaction.backToListTransaction = self.backToListTransaction;
    
    CCDropboxImagesSelectionViewController *dropboxController = [self viewController];
    dropboxController.backToListTransaction = self.backToListTransaction;
    dropboxController.dropboxPath = sendedObject[@"path"];
    dropboxController.arrayOfSelectedFiles = sendedObject[@"sellected"];
    dropboxController.noteUploadInfo = sendedObject[@"noteInfo"];
    
    dropboxController.dropboxFileSystemTransaction = fileSystemTransaction;
    [self.navigation pushViewController:dropboxController animated:YES];
}

- (CCDropboxImagesSelectionViewController *)viewController
{
    return [CCDropboxImagesSelectionViewController new];
}

- (CCDropboxImagesFileSystemTransaction *)fileSystemTransaction
{
    return [CCDropboxImagesFileSystemTransaction new];
}

@end
