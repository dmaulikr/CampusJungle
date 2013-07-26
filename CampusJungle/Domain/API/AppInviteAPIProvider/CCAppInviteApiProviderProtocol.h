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

- (void)loadAppInvitesWithPageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)sendAppInvites:(NSArray *)array successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)resendAppInvite:(CCAppInvite *)appInvite successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)deleteAppInvite:(CCAppInvite *)appInvite successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;


@end
