//
//  CCImagesSortingTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImagesSortingTransaction.h"
#import "CCImageSortingController.h"
#import "CCNoteUploadInfo.h"

@implementation CCImagesSortingTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.sortingControllerClass);
    NSParameterAssert(self.uploadingBlock);
    NSDictionary *unSortedInfo = (NSDictionary *)object;
    CCImageSortingController *sortingController = [self.sortingControllerClass new];
    sortingController.arrayOfDropboxImages = unSortedInfo[@"arrayOfDropboxItems"];
    sortingController.dropboxUploading = self.uploadingBlock;
    sortingController.backToListTransaction = self.backToListTransaction;
    [self.navigation pushViewController:sortingController animated:YES];
}

@end
