//
//  SFFaceBookAPIProtocol.h
//  Selfy
//
//  Created by Vlad Korzun on 26.04.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//
//

#import "CCTypesDefinition.h"

@protocol CCFaceBookAPIProtocol <AppleGuiceInjectable>

- (void)loginWithSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler;
- (void)getUserInfoSuccessHandler:(userInfoSuccessHandler)successHandler errorHandler:(errorHandler)errorHandler;
- (BOOL)isDeviceSessionExist;
- (void)logout;

@end
