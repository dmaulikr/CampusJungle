//
//  CCAnswersApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@class CCAnswer;

@protocol CCAnswersApiProviderProtocol <AppleGuiceInjectable>

- (void)loadAnswersForQuestionWithId:(NSString *)questionId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)postAnswer:(CCAnswer *)answer successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)deleteAnswer:(CCAnswer *)answer successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)likeAnswer:(CCAnswer *)answer successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end