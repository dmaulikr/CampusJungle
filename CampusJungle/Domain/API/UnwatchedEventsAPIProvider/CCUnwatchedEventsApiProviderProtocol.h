//
//  CCUnwatchedEventsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCUnwatchedEventsApiProviderProtocol <AppleGuiceInjectable>

- (void)resetUnwatchedEventsCounterWithSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
