//
//  CCPaymentAPIProviderProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCPaymentAPIProviderProtocol <AppleGuiceInjectable>

- (void)successPaymentWithPayPal:(NSDictionary *)paymentInfo userID:(NSString *)userID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)successPaymentWithInAppPurchase:(NSDictionary *)paymentInfo userID:(NSString *)userID successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

- (void)makeCashOutRequestWithAmount:(NSString *)amount onEmail:(NSString *)email successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
