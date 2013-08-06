//
//  CCBooksAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"
#import "CCBookUploadInfo.h"

@protocol CCBooksAPIProviderProtocol <AppleGuiceInjectable>

- (void)loadMyBookNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postDropboxUploadInfo:(CCBookUploadInfo *)bookInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postUploadInfoWithImages:(CCBookUploadInfo *)uploadInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler progress:(progressBlock)progressBlock;

- (void)makeAnOffer:(NSString *)offer toBookWithID:(NSString *)bookID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadOffersNumberOfPage:(NSNumber *)pageNumber successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)getBookWithID:(NSString *)bookID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)deleteBookWithId:(NSString *)bookId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
