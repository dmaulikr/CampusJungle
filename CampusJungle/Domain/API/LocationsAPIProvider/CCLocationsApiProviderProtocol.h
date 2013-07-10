//
//  CCLocationsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCLocationsApiProviderProtocol <AppleGuiceInjectable>

- (void)loadLocationsForClassWithId:(NSString *)classId pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;


@end
