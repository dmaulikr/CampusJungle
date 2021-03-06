//
//  CCMessageAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessageAPIProvider.h"

@implementation CCMessageAPIProvider

- (void)sendMessage:(NSString *)message toUser:(NSString *)userID dialogID:(NSString *)dialogID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSDictionary *params = @{
                             @"receiver_id" : userID,
                             @"receiver_type" : @"User",
                                 @"text" : message,
                             @"dialog_id" : dialogID
                             };
    [objectManager postObject:nil path:CCAPIDefines.postMessage parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)sendMessage:(NSString *)message ToGroupWithId:(NSString *)groupID dialogID:(NSString *)dialogID successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSDictionary *params = @{
                             @"receiver_id" : groupID,
                             @"receiver_type" : @"Group",
                             @"text" : message,
                             @"dialog_id" : dialogID
                             };

    [objectManager postObject:nil path:CCAPIDefines.postMessage parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)sendMessage:(NSString *)message toGroup:(NSString *)groupId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSDictionary *params = @{
                             @"receiver_id" : groupId,
                             @"receiver_type" : @"Group",
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

- (void)deleteMessageWithId:(NSString *)messageId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.deleteMessage, messageId];
    
    [objectManager deleteObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadMessageWithId:(NSString *)messageId successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.getMessage, messageId];
    [objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler([mappingResult firstObject]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
