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

@protocol CCAPIProviderProtocol <AppleGuiceInjectable>

- (void)putUser:(NSDictionary *)userInfo successHandler:(successHandlerWithRKResult)successHandler errorHandler:(RKErrorHandler)errorHandler;

- (void)putUserForSingUp:(NSDictionary *)userInfo successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)putUserForLogin:(NSDictionary *)userInfo successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadStatesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadCitiesInState:(NSNumber *)stateID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadCollegesInCity:(NSNumber *)cityID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)linkUserWithUserInfo:(NSDictionary *)userInfo successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)updateUser:(CCUser *)user withAvatarImage:(UIImage *)avatar successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)createCity:(NSString *)cityName stateID:(NSNumber *)stateID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)createCollege:(NSString *)collegeName cityID:(NSNumber *)cityID address:(NSString *)addess SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadUserInfoSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadMyNotesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadCollegesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadClassmatesForClass:(NSString *)classID filterString:(NSString *)filterString numberOfPage:(NSNumber *)pageNumber successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)getUserWithID:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postReviewWithRate:(NSNumber *)rank text:(NSString *)text forUserWithID:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

- (void)loadReviewsForUser:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
