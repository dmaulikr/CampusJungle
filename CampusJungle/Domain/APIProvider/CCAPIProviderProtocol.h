//
//  CCAPIProviderProtocol.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUser.h"
#import "CCTypesDefinition.h"

@protocol CCAPIProviderProtocol <AppleGuiceInjectable,AppleGuiceSingleton>

- (void)putUser:(NSDictionary *)userInfo successHandler:(successHandlerWithRKResult)successHandler errorHandler:(RKErrorHandler)errorHandler;

- (void)putUserForSingUp:(NSDictionary *)userInfo successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)putUserForLogin:(NSDictionary *)userInfo successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadStatesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadCitiesInState:(NSNumber *)stateID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadCollegesInCity:(NSNumber *)cityID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)linkUserWithUserInfo:(NSDictionary *)userInfo SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)updateUser:(CCUser *)user avatarImage:(UIImage *)avatar SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)createCity:(NSString *)cityName stateID:(NSNumber *)stateID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)createCollege:(NSString *)collegeName cityID:(NSNumber *)cityID address:(NSString *)addess SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)updateUser:(CCUser *)user withAvatarImage:(UIImage *)avatarImage SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
