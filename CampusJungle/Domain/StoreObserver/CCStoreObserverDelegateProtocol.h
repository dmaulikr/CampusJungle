//
//  CCStoreObserverDelegateProtocol.h
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCStoreObserverDelegateProtocol <NSObject>

- (void)paymentSuccessfulyFinised:(NSDictionary *)info;
- (void)paymentFailed;
- (void)productsDidLoaded:(NSArray *)arrayOfProducts;

@end
