//
//  CCDropboxSelectionViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCTransactionWithObject.h"
#import "CCNoteUploadInfo.h"

@interface CCDropboxImagesSelectionViewController : CCTableBasedController

@property (nonatomic, strong) NSString *dropboxPath;
@property (nonatomic, strong) id <CCTransactionWithObject> dropboxFileSystemTransaction;
@property (nonatomic, strong) NSMutableArray *arrayOfSelectedFiles;
@property (nonatomic, strong) CCNoteUploadInfo *noteUploadInfo;

@end
