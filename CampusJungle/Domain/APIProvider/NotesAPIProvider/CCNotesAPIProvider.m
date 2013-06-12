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

- (void)postDropboxUploadInfoWithImages:(CCNoteUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;
{
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,uploadInfo.collegeID];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    UIImage *thumb = uploadInfo.thumbnail;
    uploadInfo.thumbnail = nil;
        
    NSMutableURLRequest *request =
    [objectManager multipartFormRequestWithObject:uploadInfo
                                           method:RKRequestMethodPOST
                                             path:path
                                       parameters:nil
                        constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if(thumb){
             [formData appendPartWithFileData:UIImagePNGRepresentation(thumb)
                                         name:@"thumbnail"
                                     fileName:@"thumbnail.png"
                                     mimeType:@"image/png"];
         }
         int i = 1;
         for(UIImage *image in uploadInfo.arrayOfImages){
             NSString *fileName = [NSString stringWithFormat:@"file%d.png",i++];
             [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                         name:@"images[]"
                                     fileName:fileName
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
    
        [operation.HTTPRequestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            progressBlock((double)totalBytesWritten/totalBytesExpectedToWrite);
        }];
        [operation start];
        
    });


}

@end
