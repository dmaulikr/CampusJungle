//
//  CCGroupsApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTypesDefinition.h"

@class CCGroup;

@protocol CCGroupsApiProviderProtocol <AppleGuiceInjectable>

- (void)loadGroupsForClassWithId:(NSString *)classId filterString:(NSString *)filterString pageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)createGroup:(CCGroup *)group successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)updateGroup:(CCGroup *)group successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)leaveGroup:(CCGroup *)group successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)destroyGroup:(CCGroup *)group successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)loadMembersOfGroup:(CCGroup *)group filterString:(NSString *)filterString pageNumber:(NSNumber *)pageNumber itemsPerPage:(NSNumber *)itemsPerPage successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
