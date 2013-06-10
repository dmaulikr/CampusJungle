//
//  CCImageSortingController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCNoteUploadInfo.h"
#import "CCTransaction.h"

@interface CCImageSortingController : CCTableBasedController

@property (nonatomic, strong) NSMutableArray *arrayOfDropboxImages;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;
@property (nonatomic, strong) CCNoteUploadInfo *notesUploadInfo;

@end
