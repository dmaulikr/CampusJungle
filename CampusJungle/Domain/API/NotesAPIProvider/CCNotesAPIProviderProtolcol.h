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
#import "CCTypesDefinition.h"

@protocol CCNotesAPIProviderProtolcol  <AppleGuiceInjectable,AppleGuiceSingleton>

- (void)postDropboxUploadInfo:(CCNoteUploadInfo *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postUploadInfoWithImages:(CCNoteUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;

- (void)fetchAttachmentURLForNoteWithID:(NSString *)noteID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)removeNoteWithID:(NSString *)noteID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)resendLinkToNote:(NSString *)noteID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
