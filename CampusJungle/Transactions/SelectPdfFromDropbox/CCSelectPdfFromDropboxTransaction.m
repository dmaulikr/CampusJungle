//
//  CCSelectPdfFromDropboxTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectPdfFromDropboxTransaction.h"
#import "CCDropboxPDFSelectionViewController.h"
#import "CCDropboxPDFFileSystemTransaction.h"

@implementation CCSelectPdfFromDropboxTransaction

- (CCDropboxImagesSelectionViewController *)viewController
{
    return [CCDropboxPDFSelectionViewController new];
}

- (CCDropboxImagesFileSystemTransaction *)fileSystemTransaction
{
    return [CCDropboxPDFFileSystemTransaction new];
}

@end
