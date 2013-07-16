//
//  CCUploadImagesController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCNoteUploadInfo.h"
#import "CCTransaction.h"
#import "CCUploadingImagesDataProvider.h"
#import "CCTypesDefinition.h"

@interface CCUploadImagesController : CCTableBasedController

@property (nonatomic, strong) CCNoteUploadInfo *uploadInfo;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;
@property (nonatomic, strong) CCUploadingImagesDataProvider *dataProvider;
@property (nonatomic, copy) ImagesUploadingBlock imagesUploading;

- (IBAction)addImageButtonDidPressed;

@end
