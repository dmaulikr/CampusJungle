//
//  CCGroupInvitesApiProviderProtocol.h
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTypesDefinition.h"

@protocol CCGroupInvitesApiProviderProtocol <AppleGuiceInjectable>

- (void)loadGroupInvitesPageNumber:(NSNumber *)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)sendInvitesInGroup:(NSString *)groupId withText:(NSString *)text toUsersWithIds:(NSArray *)userIds successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)resendGroupInviteWithId:(NSString *)groupInviteId successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)acceptGroupInviteWithId:(NSString *)groupInviteId successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)rejectGroupInviteWithId:(NSString *)groupInviteId successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;
- (void)deleteGroupInviteWithId:(NSString *)groupInviteId successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler;

@end
