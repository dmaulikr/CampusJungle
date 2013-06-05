//
//  CCDropboxFileSelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxFileSelectionTransaction.h"
#import "CCDropboxSelectionViewController.h"

@implementation CCDropboxFileSelectionTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCDropboxSelectionViewController *dropboxController = [CCDropboxSelectionViewController new];
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:dropboxController];
    
    self.menuController.centerPanel = centralNavigation;
}

@end
