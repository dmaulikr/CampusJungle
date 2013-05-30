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
    
    [objectManager putObject:nil
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
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
       [params setObject:query forKey:@"name"];
    }
    [self loadItemsWithParams:params path:CCAPIDefines.states successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadCitiesInState:(NSNumber *)stateID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
        [params setObject:query forKey:@"name"];
    }
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.cities, stateID];
    
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadCollegesInCity:(NSNumber *)cityID NumberOfPage:(NSNumber *)pageNumber query:(NSString *)query successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:pageNumber.stringValue forKey:@"page_number"];
    if (query) {
        [params setObject:query forKey:@"name"];
    }
    
    NSString *path = [NSString stringWithFormat:CCAPIDefines.colleges, cityID];
    
    [self loadItemsWithParams:params path:path successHandler:successHandler errorHandler:errorHandler];
}

- (void)loadItemsWithParams:(NSDictionary *)params path:(NSString *)path successHandler:(successHandlerWithRKResult)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    [objectManager getObjectsAtPath:path parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successHandler(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

- (void)linkUserWithUserInfo:(NSDictionary *)userInfo SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    [objectManager putObject:nil
                        path:CCAPIDefines.linkFacebook
                  parameters:userInfo
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                     }];
}

- (void)updateUser:(CCUser *)user SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [self setAuthorizationToken];
    
    [objectManager putObject:user
                        path:CCAPIDefines.updateUser
                  parameters:nil
                     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                         successHandler(mappingResult.firstObject);
                     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                         errorHandler(error);
                }];
}

@end
