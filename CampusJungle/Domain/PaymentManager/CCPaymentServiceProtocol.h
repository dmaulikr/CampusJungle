//
//  CCPaymentManagerProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCPaymentServiceProtocol <AppleGuiceInjectable, AppleGuiceSingleton>

- (void)addPayPalPayment:(NSDictionary *)payment;
- (void)addInAppPurchasePayment:(NSDictionary *)payment;

- (void)resendAllPayments;

@end
