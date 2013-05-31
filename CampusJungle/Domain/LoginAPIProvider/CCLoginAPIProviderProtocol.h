//
//  CCLoginAPIProviderProtocol.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTypesDefinition.h"

@protocol CCLoginAPIProviderProtocol <AppleGuiceInjectable>

- (void)performLoginOperationViaFacebookWithSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)performLoginOperationViaTwitterWithUserInfo:(NSDictionary *)userDictionary SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)performLoginOperationWithUserInfo:(NSDictionary *)userInfo successHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler;

- (void)linkWithFacebookSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
