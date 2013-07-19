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
    NSDictionary *params = nil;
    if(filterString){
        params = @{@"keywords":filterString};
    }
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)postQuestion:(CCProfessorUpload *)profesorUploads
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

- (void)deleteQuestion:(CCProfessorUpload *)profesorUploads
        successHandler:(successHandlerWithRKResult)successHandler
          errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    [objectManager deleteObject:profesorUploads
                           path:CCAPIDefines.deleteUploads
                     parameters:nil success:
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
                    progress:^(double a){}];
}

@end
