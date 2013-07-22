//
//  CCProfessorUploadsAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorUploadsAPIProvider.h"
#import "CCProfessorUpload.h"

@implementation CCProfessorUploadsAPIProvider

- (void)loadUploadsForClassWithId:(NSString *)classId
                     filterString:(NSString *)filterString
                       pageNumber:(NSInteger)pageNumber
                   successHandler:(successWithObject)successHandler
                     errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.loadUploads,classId];
    NSMutableDictionary *params = [@{@"page_number" : @(pageNumber)} mutableCopy];
    if(filterString){
        [params addEntriesFromDictionary:@{@"keywords":filterString}];
    }
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)postUploadInfo:(CCProfessorUpload *)profesorUploads
      ForClassWithId:(NSString *)classId
      successHandler:(successHandlerWithRKResult)successHandler
        errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.postUploads,classId];
    [self postInfoWithObject:profesorUploads
                   thumbnail:nil
                      images:nil
                      onPath:path
              successHandler:successHandler
                errorHandler:errorHandler
                    progress:^(double a){}];
}

- (void)deleteUploadInfo:(CCProfessorUpload *)profesorUploads
        successHandler:(successHandlerWithRKResult)successHandler
          errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.deleteUploads,profesorUploads.uploadId];
    [objectManager deleteObject:profesorUploads
                           path:path
                     parameters:nil
                        success:
     ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult);
                     } failure:
     ^(RKObjectRequestOperation *operation, NSError *error) {
         errorHandler(error);
     }];
}

- (void)postUploadInfo:(CCProfessorUpload *)profesorUploads
        ForClassWithId:(NSString *)classId
            withImages:(NSArray *)images
        successHandler:(successWithObject)successHandler
          errorHandler:(errorHandler)errorHandler
              progress:(progressBlock)progressBlock
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.postUploads,classId];
    [self postInfoWithObject:profesorUploads
                   thumbnail:nil
                      images:images
                      onPath:path
              successHandler:successHandler
                errorHandler:errorHandler
                    progress:progressBlock];
}

- (void)emailAttachmentOfUpload:(CCProfessorUpload *)upload
                 successHandler:(successWithObject)successHandler
                   errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.emailUploadsAttachment, upload.uploadId];
    [objectManager putObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}


@end
