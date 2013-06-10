//
//  CCNotesAPIProviderProtolcol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDropboxFileInfo.h"
#import "CCNoteUploadInfo.h"

@protocol CCNotesAPIProviderProtolcol  <AppleGuiceInjectable,AppleGuiceSingleton>

- (void)postDropboxUploadInfo:(CCNoteUploadInfo *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postDropboxUploadInfoWithImages:(CCNoteUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
