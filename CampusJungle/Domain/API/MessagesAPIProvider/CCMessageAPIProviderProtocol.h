//
//  CCMessageAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCMessageAPIProviderProtocol <AppleGuiceInjectable>

- (void)sendMessage:(NSString *)message toUser:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;;

- (void)loadMyMessagesWithParams:(NSDictionary *)params successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
