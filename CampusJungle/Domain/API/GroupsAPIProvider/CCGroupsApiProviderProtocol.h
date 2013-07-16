//
//  CCGroupsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@protocol CCGroupsApiProviderProtocol <AppleGuiceInjectable>

- (void)loadGroupsForClassWithId:(NSString *)classId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
