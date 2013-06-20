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
    successHandler(nil);
}

- (void)postUploadInfoWithImages:(CCStuffUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock
{
    UIImage *thumb = uploadInfo.thumbnail;
    NSString *path = [NSString stringWithFormat:CCAPIDefines.createStuff,uploadInfo.collegeID];
    
    [self postInfoWithObject:uploadInfo thumbnail:thumb images:uploadInfo.arrayOfImages onPath:path successHandler:successHandler errorHandler:errorHandler progress:progressBlock];
}

@end