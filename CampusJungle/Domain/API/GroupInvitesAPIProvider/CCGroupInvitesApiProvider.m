//
//  CCGroupInvitesApiProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupInvitesApiProvider.h"

@implementation CCGroupInvitesApiProvider

- (void)sendInvitesInGroup:(NSString *)groupId withText:(NSString *)text toUsersWithIds:(NSArray *)userIds successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSDictionary *params = @{@"text" : text, @"users_ids" : userIds};
    NSString *path = [NSString stringWithFormat:CCAPIDefines.sendGroupInvite, groupId];
    [objectManager postObject:nil path:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
