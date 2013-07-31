//
//  CCStoreObserver.h
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol CCStoreObserverDelegate <NSObject>

- (void)paymentSuccessfulyFinised:(NSDictionary *)info;
- (void)paymentFailed;

@end

@interface CCStoreObserver : NSObject<SKPaymentTransactionObserver>

@property (nonatomic, weak) id <CCStoreObserverDelegate> delegate;

@end
