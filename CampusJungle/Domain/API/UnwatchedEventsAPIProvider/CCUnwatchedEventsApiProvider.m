//
//  CCUnwatchedEventsApiProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUnwatchedEventsApiProvider.h"

@implementation CCUnwatchedEventsApiProvider

- (void)resetUnwatchedEventsCounterWithSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = CCAPIDefines.resetUnwatchedEvents;
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    [objectManager putObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
