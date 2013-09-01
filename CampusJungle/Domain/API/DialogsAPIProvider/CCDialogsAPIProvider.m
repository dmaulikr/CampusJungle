//
//  CCDialogsAPIProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 16.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDialogsAPIProvider.h"

@implementation CCDialogsAPIProvider

- (void)loadMyDialogsPageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self loadItemsWithParams:@{@"page_number" : @(pageNumber)} path:CCAPIDefines.myDialogs successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadDialogWithUser:(NSString *)userID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSString *path = [NSString stringWithFormat:CCAPIDefines.dialogForUserWithID,userID];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadMessagesForDialogWithID:(NSString *)dialogID DialogsPageNumber:(NSInteger)pageNumber successHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.messagesForDialog,dialogID];
    [self loadItemsWithParams:@{
     @"page_number" : @(pageNumber)
     } path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadDialogWithID:(NSString *)dialogID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.dialogWithId,dialogID];
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadDialogForGroupWithID:(NSString *)groupID SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *path = [NSString stringWithFormat:CCAPIDefines.dialogForGroupWithID,groupID];
    [self setAuthorizationToken];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult.firstObject);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
    
}

@end
