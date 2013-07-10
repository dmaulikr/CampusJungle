//
//  CCMessageAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessageAPIProvider.h"

@implementation CCMessageAPIProvider

- (void)sendMessage:(NSString *)message toUser:(NSString *)userID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSDictionary *params = @{
                             @"receiver_id" : userID,
                             @"receiver_type" : @"User",
                                 @"text" : message
                             };
    [objectManager postObject:nil path:CCAPIDefines.postMessage parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadMyMessagesWithParams:(NSDictionary *)params successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self loadItemsWithParams:params path:CCAPIDefines.loadMyMessages successHandler:successHandler errorHandler:errorHandler];
}

@end
