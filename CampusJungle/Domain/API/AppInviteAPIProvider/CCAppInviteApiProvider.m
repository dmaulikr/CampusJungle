//
//  CCAppInviteApiProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppInviteApiProvider.h"
#import "CCAppInvite.h"

@implementation CCAppInviteApiProvider

- (void)sendAppInviteWithSuccessHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler;
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = CCAPIDefines.sendAppInvites;
    [objectManager postObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
