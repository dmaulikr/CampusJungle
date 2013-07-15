//
//  CCDropboxFileSelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxImagesSelectionTransaction.h"
#import "CCImagesSortingTransaction.h"
#import "CCDropboxImagesFileSystemTransaction.h"
#import "CCImageSortingController.h"

@implementation CCDropboxImagesSelectionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.backToListTransaction);
    
    CCDropboxImagesFileSystemTransaction *fileSystemTransaction = [self fileSystemTransaction];
    CCImagesSortingTransaction *sortingTransaction = [CCImagesSortingTransaction new];
    sortingTransaction.sortingControllerClass = [self sortingControllerClass];
    fileSystemTransaction.imagesSortingTransaction = sortingTransaction;
    sortingTransaction.navigation = self.navigation;
    sortingTransaction.backToListTransaction = self.backToListTransaction;
    
    fileSystemTransaction.backToListTransaction = self.backToListTransaction;
    fileSystemTransaction.navigation = self.navigation;
    
    CCDropboxImagesSelectionViewController *dropboxController = [self viewController];
    dropboxController.imageSortingTransaction = sortingTransaction;
    dropboxController.backToListTransaction = self.backToListTransaction;
    dropboxController.arrayOfSelectedFiles = [NSMutableArray new];
    dropboxController.dropboxPath = @"/";
    dropboxController.dropboxFileSystemTransaction = fileSystemTransaction;
    dropboxController.uploadInfo = object;
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

- (Class)sortingControllerClass
{
    return [CCImageSortingController class];
}

@end