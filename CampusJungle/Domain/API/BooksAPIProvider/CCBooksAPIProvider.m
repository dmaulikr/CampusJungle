//
//  CCBooksAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBooksAPIProvider.h"

@implementation CCBooksAPIProvider

- (void)loadMyBookNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
        [params setObject:query forKey:@"name"];
    }
    [self loadItemsWithParams:params path:CCAPIDefines.loadMyBooks successHandler:successHandler errorHandler:errorHandler];
}

- (void)postDropboxUploadInfo:(CCBookUploadInfo *)BookInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.createBook,BookInfo.collegeID];
    
    [self postInfoWithObject:BookInfo thumbnail:BookInfo.thumbnail images:nil onPath:path successHandler:successHandler errorHandler:errorHandler progress:^(double finished) {
        
    }];
}

- (void)postUploadInfoWithImages:(CCBookUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock
{
    UIImage *thumb = uploadInfo.thumbnail;
    NSString *path = [NSString stringWithFormat:CCAPIDefines.createBook,uploadInfo.collegeID];
    
    [self postInfoWithObject:uploadInfo thumbnail:thumb images:uploadInfo.arrayOfImages onPath:path successHandler:successHandler errorHandler:errorHandler progress:progressBlock];
}

- (void)makeAnOffer:(NSString *)offer toBookWithID:(NSString *)bookID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.makeBookOffer,bookID];
    [objectManager postObject:nil path:path parameters:@{@"text" : offer}
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                          successHandler(mappingResult);
                      }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          errorHandler(error);
                      }];
}

- (void)loadOffersNumberOfPage:(NSNumber *)pageNumber successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self loadItemsWithParams:@{
     @"page_number" : pageNumber.stringValue,
     @"direction" : @"received"
     }
                         path:CCAPIDefines.recivedOffers
               successHandler:successHandler
                 errorHandler:errorHandler];
}

- (void)getBookWithID:(NSString *)bookID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.getBook,bookID];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)deleteBookWithId:(NSString *)bookId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.deleteBook, bookId];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    [objectManager deleteObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
