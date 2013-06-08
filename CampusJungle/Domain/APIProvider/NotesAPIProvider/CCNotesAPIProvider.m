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

- (void)postDropboxPdfMetadata:(id)metadata noteInfo:(NSDictionary *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    
}

- (void)postDropboxUploadInfo:(CCNoteUploadInfo *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{

    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,noteInfo.collegeID];

    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    UIImage *thumb = noteInfo.thumbnail;
    noteInfo.thumbnail = nil;
    
    NSMutableURLRequest *request =
    [objectManager multipartFormRequestWithObject:noteInfo
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

@end
