//
//  CCSettingsAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSettingsAPIProvider.h"

@implementation CCSettingsAPIProvider

- (void)getSettingsSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    [[RKObjectManager sharedManager] getObject:nil path:CCAPIDefines.getSettings parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)uploadSettings:(CCSettings *)settings successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    [[RKObjectManager sharedManager] putObject:settings path:CCAPIDefines.setSettings parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
