//
//  CCGroupInvitesApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTypesDefinition.h"

@protocol CCGroupInvitesApiProviderProtocol <AppleGuiceInjectable>

- (void)sendInvitesInGroup:(NSString *)groupId withText:(NSString *)text toUsersWithIds:(NSArray *)userIds successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
