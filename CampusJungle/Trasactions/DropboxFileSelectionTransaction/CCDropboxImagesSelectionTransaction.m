//
//  CCDropboxFileSelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxImagesSelectionTransaction.h"
#import "CCDropboxSelectionViewController.h"
#import "CCDropboxFileSystemTransaction.h"

@implementation CCDropboxImagesSelectionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCDropboxFileSystemTransaction *fileSystemTransaction = [CCDropboxFileSystemTransaction new];
    fileSystemTransaction.navigation = self.navigation;
    
    CCDropboxSelectionViewController *dropboxController = [CCDropboxSelectionViewController new];
    dropboxController.arrayOfSelectedFiles = [NSMutableArray new];
    dropboxController.dropboxPath = @"/";
    dropboxController.dropboxFileSystemTransaction = fileSystemTransaction;

    [self.navigation pushViewController:dropboxController animated:YES];
}

@end
