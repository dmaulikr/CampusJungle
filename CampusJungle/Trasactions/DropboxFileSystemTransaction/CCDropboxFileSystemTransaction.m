//
//  CCDropboxFileSystemTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxFileSystemTransaction.h"
#import "CCDropboxSelectionViewController.h"

@implementation CCDropboxFileSystemTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSDictionary *sendedObject = object;
    CCDropboxFileSystemTransaction *fileSystemTransaction = [CCDropboxFileSystemTransaction new];
    fileSystemTransaction.navigation = self.navigation;
    
    CCDropboxSelectionViewController *dropboxController = [CCDropboxSelectionViewController new];
    dropboxController.dropboxPath = sendedObject[@"path"];
    dropboxController.arrayOfSelectedFiles = sendedObject[@"sellected"];
    dropboxController.dropboxFileSystemTransaction = fileSystemTransaction;
    [self.navigation pushViewController:dropboxController animated:YES];
}

@end
