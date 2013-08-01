//
//  CCStoreObserverProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "CCStoreObserverDelegateProtocol.h"

@protocol CCStoreObserverProtocol <AppleGuiceInjectable, AppleGuiceSingleton, SKPaymentTransactionObserver>

@property (nonatomic, weak) id <CCStoreObserverDelegateProtocol> delegate;

- (void)loadProducts;

@end
