//
//  CCCommentsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@class CCComment;

@protocol CCCommentsApiProviderProtocol <AppleGuiceInjectable>

- (void)loadCommentsForAnswerWithId:(NSString *)answerId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)postComment:(CCComment *)comment successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)deleteComment:(CCComment *)comment successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
