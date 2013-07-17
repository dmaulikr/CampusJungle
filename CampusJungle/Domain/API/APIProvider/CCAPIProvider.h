//
//  CCAPIProvider.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAPIProviderProtocol.h"

@interface CCAPIProvider : NSObject<CCAPIProviderProtocol>

- (void)setAuthorizationToken;
- (void)setContentTypeJSON;

- (void)loadItemsWithParams:(NSDictionary *)params path:(NSString *)path successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postInfoWithObject:(id)object thumbnail:(UIImage *)thumb images:(NSArray *)images onPath:(NSString *)path successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;

- (void)loadCollegesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)putInfoWithObject:(id)object thumbnail:(UIImage *)thumb images:(NSArray *)images onPath:(NSString *)path successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;

@end
