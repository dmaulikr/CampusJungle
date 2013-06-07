//
//  CCDropboxFileSelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxFileSelectionTransaction.h"
#import "CCDropboxSelectionViewController.h"
#import "CCDropboxFileSystemTransaction.h"

@implementation CCDropboxFileSelectionTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCDropboxFileSystemTransaction *fileSystemTransaction = [CCDropboxFileSystemTransaction new];

    CCDropboxSelectionViewController *dropboxController = [CCDropboxSelectionViewController new];
    dropboxController.arrayOfSelectedUser = [NSMutableArray new];
    dropboxController.dropboxPath = @"/";
    dropboxController.dropboxFileSystemTransaction = fileSystemTransaction;
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:dropboxController];
    fileSystemTransaction.navigation = centralNavigation;
    self.menuController.centerPanel = centralNavigation;
}

@end
