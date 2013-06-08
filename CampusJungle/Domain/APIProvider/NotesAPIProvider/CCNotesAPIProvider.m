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

- (void)postDropboxImagesMetadata:(NSArray *)arrayOfMetadata noteInfo:(NSDictionary *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSMutableArray *arrayOfUrls = [NSMutableArray new];
    for(CCDropboxFileInfo *info in arrayOfMetadata){
        [arrayOfUrls addObject:info.directLink];
    }
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,@20429];
    NSString *description = @"Some description";
    NSNumber *price = @1000;
    [self setAuthorizationToken];
    [objectManager postObject:nil
                        path:path
                  parameters:@{
     @"price":price,
     @"images_urls":arrayOfUrls,
     @"description":description,
     }
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult.firstObject);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                     }];
    
}

- (void)postDropboxPdfMetadata:(id)metadata noteInfo:(NSDictionary *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    
}

- (void)postDropboxUploadInfo:(CCNoteUploadInfo *)noteInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
     RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.uploadNotesPath,noteInfo.collegeID];
    [objectManager postObject:objectManager
                         path:path
                   parameters:nil
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];


}

@end
