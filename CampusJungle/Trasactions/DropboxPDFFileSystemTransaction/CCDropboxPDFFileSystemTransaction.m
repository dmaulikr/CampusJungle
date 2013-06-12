//
//  CCDropboxPDFFileSystemTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxPDFFileSystemTransaction.h"
#import "CCDropboxPDFSelectionViewController.h"

@implementation CCDropboxPDFFileSystemTransaction

- (CCDropboxImagesSelectionViewController *)viewController
{
    return [CCDropboxPDFSelectionViewController new];
}

- (CCDropboxImagesFileSystemTransaction *)fileSystemTransaction
{
    return [CCDropboxPDFFileSystemTransaction new];
}

@end
