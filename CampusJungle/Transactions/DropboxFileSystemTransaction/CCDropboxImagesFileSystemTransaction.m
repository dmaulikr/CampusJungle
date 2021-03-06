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
    NSParameterAssert(self.imagesSortingTransaction);
    
    NSDictionary *sendedObject = object;
    CCDropboxImagesFileSystemTransaction *fileSystemTransaction = [self fileSystemTransaction];
    fileSystemTransaction.navigation = self.navigation;
    fileSystemTransaction.backToListTransaction = self.backToListTransaction;
    fileSystemTransaction.imagesSortingTransaction = self.imagesSortingTransaction;
    fileSystemTransaction.uploadingBlock = self.uploadingBlock;
    
    CCDropboxImagesSelectionViewController *dropboxController = [self viewController];
    dropboxController.uploadingBlock = self.uploadingBlock;
    dropboxController.imageSortingTransaction = self.imagesSortingTransaction;
    dropboxController.backToListTransaction = self.backToListTransaction;
    dropboxController.dropboxPath = sendedObject[@"path"];
    dropboxController.arrayOfSelectedFiles = sendedObject[@"sellected"];
    
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
