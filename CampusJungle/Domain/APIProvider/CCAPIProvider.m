//
//  CCAPIProvider.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAPIProvider.h"
#import "CCUserSessionProtocol.h"
#import "CCDefines.h"

@interface CCAPIProvider()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCAPIProvider

- (void)setAuthorizationToken
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSString *valueForHeader = [NSString stringWithFormat: @"Token token=%@",self.ioc_userSession.currentUser.token];
    [objectManager.HTTPClient setDefaultHeader:@"Authorization" value:valueForHeader];
}

- (void)putUser:(NSDictionary *)userInfo
 successHandler:(successHandlerWithRKResult)successHandler
   errorHandler:(RKErrorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager putObject:nil
                         path:CCAPIDefines.authorization
                   parameters:userInfo success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       if(successHandler){
                           successHandler(mappingResult);
                       }
                   }
                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                          if(errorHandler){
                              errorHandler(operation, error);
                          }
                      }];
}

- (void)putUserForSingUp:(NSDictionary *)userInfo
          successHandler:(successHandlerWithRKResult)successHandler
            errorHandler:(errorHandler)errorHandler{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager postObject:nil path:CCAPIDefines.signUp parameters:userInfo success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)putUserForLogin:(NSDictionary *)userInfo
         successHandler:(successHandlerWithRKResult)successHandler
           errorHandler:(errorHandler)errorHandler{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [objectManager postObject:nil
                         path:CCAPIDefines.login
                   parameters:userInfo
                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)loadStatesNumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [objectManager getObjectsAtPath:@"/api/states" parameters:@{@"name" : query} success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];


}



@end
