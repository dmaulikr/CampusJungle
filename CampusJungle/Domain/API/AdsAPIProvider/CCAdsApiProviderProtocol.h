//
//  CCAdsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCAdsApiProviderProtocol <AppleGuiceInjectable>

- (void)loadAdsInClassWithId:(NSString *)classId pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
