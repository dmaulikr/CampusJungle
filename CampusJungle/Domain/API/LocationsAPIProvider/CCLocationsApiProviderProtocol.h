//
//  CCLocationsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@class CCLocation;

@protocol CCLocationsApiProviderProtocol <AppleGuiceInjectable>

- (void)loadLocationsForClassWithId:(NSString *)classId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)loadLocationsForGroupWithId:(NSString *)groupId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)postToClassLocation:(CCLocation *)location successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)postToGroupLocation:(CCLocation *)location successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)deleteLocation:(CCLocation *)location successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
