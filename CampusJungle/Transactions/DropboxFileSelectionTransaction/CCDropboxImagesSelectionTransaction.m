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
    
    CCDropboxImagesFileSystemTransaction *fileSystemTransaction = [self fileSystemTransaction];
    CCImagesSortingTransaction *sortingTransaction = [CCImagesSortingTransaction new];
    sortingTransaction.sortingControllerClass = [self sortingControllerClass];
    fileSystemTransaction.imagesSortingTransaction = sortingTransaction;
    sortingTransaction.navigation = self.navigation;
    sortingTransaction.backToListTransaction = self.backToListTransaction;
    sortingTransaction.uploadingBlock = object;
    
    fileSystemTransaction.backToListTransaction = self.backToListTransaction;
    fileSystemTransaction.navigation = self.navigation;
    fileSystemTransaction.uploadingBlock = object;
    
    CCDropboxImagesSelectionViewController *dropboxController = [self viewController];
    dropboxController.uploadingBlock = object;
    dropboxController.imageSortingTransaction = sortingTransaction;
    dropboxController.backToListTransaction = self.backToListTransaction;
    dropboxController.arrayOfSelectedFiles = [NSMutableArray new];
    dropboxController.dropboxPath = @"/";
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

- (Class)sortingControllerClass
{
    return [CCImageSortingController class];
}

@end
