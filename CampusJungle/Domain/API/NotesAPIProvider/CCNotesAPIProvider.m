//
//  CCNotesAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNotesAPIProvider.h"
#import "CCDropboxFileInfo.h"
#import "CCDefines.h"

@implementation CCNotesAPIProvider

- (void)postDropboxUploadInfo:(CCNoteUploadInfo *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{

    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,noteInfo.collegeID];

    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    UIImage *thumb = noteInfo.thumbnail;
    noteInfo.thumbnail = nil;
    
    NSDictionary *params;
    if(noteInfo.arrayOfURLs){
        params = @{@"images_urls" : noteInfo.arrayOfURLs};
    } else {
        params = @{@"pdf_url" : noteInfo.pdfUrl};
    }
    
    NSMutableURLRequest *request =
    [objectManager multipartFormRequestWithObject:noteInfo
                                           method:RKRequestMethodPOST
                                             path:path
                                       parameters:params
                        constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if(thumb){
             [formData appendPartWithFileData:UIImagePNGRepresentation(thumb)
                                         name:@"thumbnail"
                                     fileName:@"thumbnail.png"
                                     mimeType:@"image/png"];
         }
     }];
    
    RKObjectRequestOperation *operation =
    [objectManager objectRequestOperationWithRequest:request
                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         if(successHandler){
             successHandler(mappingResult.firstObject);
         }
     }
                                             failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                 if(successHandler){
                                                     errorHandler(error);
                                                 }
                                             }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [operation start];
    });
}


- (void)postUploadInfoWithImages:(CCNoteUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;
{
    UIImage *thumb = uploadInfo.thumbnail;
    uploadInfo.thumbnail = nil;
       NSString *path = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,uploadInfo.collegeID];
    
    [self postInfoWithObject:uploadInfo thumbnail:thumb images:uploadInfo.arrayOfImages onPath:path successHandler:successHandler errorHandler:errorHandler progress:progressBlock];
}

- (void)fetchAttachmentURLForNoteWithID:(NSString *)noteID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.notesAttachmentURL,noteID];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];

    [self setContentTypeJSON];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)removeNoteWithID:(NSString *)noteID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.removeNote,noteID];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [objectManager deleteObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)resendLinkToNote:(NSString *)noteID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.resendLinkToNote,noteID];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [objectManager putObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadPurchasedNotesSearchQuery:(NSString *)query PageNumber:(NSNumber *)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [@{@"page_number" : pageNumber} mutableCopy];
    if(query){
        [params setObject:params forKey:@"keywords"];
    }
    [self loadItemsWithParams:params path:CCAPIDefines.purchasedNotes successHandler:successHandler errorHandler:errorHandler];
}

@end
