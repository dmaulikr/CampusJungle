//
//  CCUploadImagesController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCNoteUploadInfo.h"

@interface CCUploadImagesController : CCTableBasedController

@property (nonatomic, strong) CCNoteUploadInfo *noteInfo;

- (IBAction)addImageButtonDidPressed;

@end
