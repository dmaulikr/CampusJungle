//
//  CCImagesForNotesUploadingScreenTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImagesUploadingScreenTransaction.h"
#import "CCUploadImagesController.h"

@implementation CCImagesUploadingScreenTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.naviation);
    
    CCUploadImagesController *uploadImagesController = [CCUploadImagesController new];

    uploadImagesController.imagesUploading = object;
    uploadImagesController.backToListTransaction = self.backToListTransaction;
    
    [self.naviation pushViewController:uploadImagesController animated:YES];
}

@end
