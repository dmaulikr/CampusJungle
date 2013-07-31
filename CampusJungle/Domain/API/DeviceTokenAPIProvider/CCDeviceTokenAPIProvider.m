//
//  CCDeviceTokenAPIProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDeviceTokenAPIProvider.h"

@implementation CCDeviceTokenAPIProvider

- (void)linkDeviceToken:(NSString *)deviceToken successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSDictionary *params = @{@"device_token" : deviceToken};
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = CCAPIDefines.linkDevice;
    [objectManager putObject:nil path:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)unlinkDeviceToken:(NSString *)deviceToken successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSDictionary *params = @{@"device_token" : deviceToken};
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    NSString *path = CCAPIDefines.unlinkDevice;
    [objectManager deleteObject:nil path:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
