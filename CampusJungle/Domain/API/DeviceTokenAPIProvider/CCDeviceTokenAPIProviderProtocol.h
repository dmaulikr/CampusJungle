//
//  CCDeviceTokenAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCDeviceTokenAPIProviderProtocol <AppleGuiceInjectable>

- (void)linkDeviceToken:(NSString *)deviceToken successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
- (void)unlinkDeviceToken:(NSString *)deviceToken successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;

@end
