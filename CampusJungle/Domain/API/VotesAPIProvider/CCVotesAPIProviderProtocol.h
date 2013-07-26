//
//  CCVotesAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCVotesAPIProviderProtocol <AppleGuiceInjectable>

- (void)loadFeedbackForClassWithID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)postFeedback:(NSDictionary *)feedback classID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)recalculateFeedbackInClassWithID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)checkVoitingAvailabilityForClassWithID:(NSString *)classID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
