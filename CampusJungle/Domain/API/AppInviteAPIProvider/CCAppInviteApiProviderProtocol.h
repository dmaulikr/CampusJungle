//
//  CCAppInviteApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@class CCAppInvite;

@protocol CCAppInviteApiProviderProtocol <AppleGuiceInjectable>

- (void)sendAppInviteWithSuccessHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
