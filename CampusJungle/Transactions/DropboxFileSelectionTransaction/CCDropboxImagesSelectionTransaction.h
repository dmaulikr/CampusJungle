//
//  CCDropboxFileSelectionTransaction.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"
#import "CCDropboxImagesSelectionViewController.h"
#import "CCDropboxImagesFileSystemTransaction.h"


@interface CCDropboxImagesSelectionTransaction : NSObject <CCTransactionWithObject>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;

- (CCDropboxImagesSelectionViewController *)viewController;
- (CCDropboxImagesFileSystemTransaction *)fileSystemTransaction;

@end
