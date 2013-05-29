//
//  CCRestKitConfigurator.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCRestKitConfigurator.h"
#import <RestKit/RestKit.h>
#import "CCDefines.h"
#import "CCAlertDefines.h"
#import "CCUser.h"
#import "CCAuthorization.h"
#import "CCAuthorizationResponse.h"
#import "CCPaginationResponse.h"
#import "CCState.h"

@implementation CCRestKitConfigurator

+ (void)configure
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    NSURL *baseURL = [NSURL URLWithString:CCAPIDefines.baseURL];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    [objectManager.HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CCAlertsMessages.noInternetConnection
                                                            message:CCAlertsMessages.connectToTheInternet
                                                           delegate:nil
                                                  cancelButtonTitle:CCAlertsButtons.okButton
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    [CCRestKitConfigurator configureUserResponse:objectManager];
    [CCRestKitConfigurator configurePaginationResponse:objectManager];
}

+ (void)configureUserResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping* userResponseMapping = [RKObjectMapping mappingForClass:[CCUser class]];
    
    [userResponseMapping addAttributeMappingsFromDictionary:@{
        @"first_name" : @"firstName",
        @"last_name" : @"lastName",
        @"email" : @"email",
        @"avatar" : @"avatar",
        @"token" : @"token",
        @"wallet" : @"wallet",
        @"status" : @"status",
        @"id" : @"uid",
        @"rank" : @"rank",
     }];

    
    
    
     RKRelationshipMapping* relationShipResponseUserMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"user"
                                                                                                         toKeyPath:@"user"
                                                                                                       withMapping:userResponseMapping];
     RKObjectMapping *authorizationResponseMapping = [RKObjectMapping mappingForClass:[CCAuthorizationResponse class]];
    [authorizationResponseMapping addPropertyMapping:relationShipResponseUserMapping];

    [authorizationResponseMapping addAttributeMappingsFromDictionary:
     @{
        @"is_new_user" : @"isFirstLaunch",
     }];
    
    RKResponseDescriptor *responseAuthorizationDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:authorizationResponseMapping
                                                                                           pathPattern:CCAPIDefines.authorization
                                                                                               keyPath:nil
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *responseSignUpDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:authorizationResponseMapping
                                                                                                    pathPattern:CCAPIDefines.signUp
                                                                                                        keyPath:nil
                                                                                                    statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKResponseDescriptor *responseLoginDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:authorizationResponseMapping
                                                                                             pathPattern:CCAPIDefines.login
                                                                                                 keyPath:nil
                                                                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseAuthorizationDescriptor];
    [objectManager addResponseDescriptor:responseSignUpDescriptor];
    [objectManager addResponseDescriptor:responseLoginDescriptor];
}

+ (void)configurePaginationResponse:(RKObjectManager *)objectManager
{
    RKObjectMapping *paginationResponseMapping  = [RKObjectMapping mappingForClass:[CCPaginationResponse class]];
    [paginationResponseMapping addAttributeMappingsFromDictionary:@{@"count": @"count"}];
    
    RKObjectMapping *statesMapping = [RKObjectMapping mappingForClass:[CCState class]];
    [statesMapping addAttributeMappingsFromDictionary:@{
        @"id" : @"stateID",
        @"name" : @"name"
     }];
    RKRelationshipMapping* relationShipResponseStatesMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"states"
                                                                                                         toKeyPath:@"items"
                                                                                                       withMapping:statesMapping];
    [paginationResponseMapping addPropertyMapping:relationShipResponseStatesMapping];
    
    RKResponseDescriptor *responsePagination = [RKResponseDescriptor responseDescriptorWithMapping:paginationResponseMapping pathPattern:CCAPIDefines.states keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responsePagination];

}

@end
