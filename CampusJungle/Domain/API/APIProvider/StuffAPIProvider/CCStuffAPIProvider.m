//
//  CCStuffAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffAPIProvider.h"
#import "CCDefines.h"

@implementation CCStuffAPIProvider

- (void)loadMyStuffNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
        [params setObject:query forKey:@"name"];
    }
    [self loadItemsWithParams:params path:CCAPIDefines.loadMyStuff successHandler:successHandler errorHandler:errorHandler];
}

- (void)postDropboxUploadInfo:(CCStuffUploadInfo *)stuffInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.createStuff,stuffInfo.collegeID];
    [objectManager postObject:stuffInfo path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
     
    successHandler(nil);
}

- (void)postUploadInfoWithImages:(CCStuffUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock
{
    UIImage *thumb = uploadInfo.thumbnail;
    NSString *path = [NSString stringWithFormat:CCAPIDefines.createStuff,uploadInfo.collegeID];
    
    [self postInfoWithObject:uploadInfo thumbnail:thumb images:uploadInfo.arrayOfImages onPath:path successHandler:successHandler errorHandler:errorHandler progress:progressBlock];
}

- (void)makeAnOffer:(NSString *)offer toStuffWithID:(NSString *)stuffID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.makeOffer,stuffID];
    [objectManager postObject:nil path:path parameters:@{@"text" : offer} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadOffersNumberOfPage:(NSNumber *)pageNumber successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self loadItemsWithParams:@{@"page_number" : pageNumber.stringValue}
                         path:CCAPIDefines.recivedOffers
               successHandler:successHandler
                 errorHandler:errorHandler];
}

@end
