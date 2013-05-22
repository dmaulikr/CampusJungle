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
    [CCRestKitConfigurator configureUser:objectManager];

}


+(void)configureUser:(RKObjectManager*)objectManager
{
    RKObjectMapping* userMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [userMapping addAttributeMappingsFromDictionary:@{
     @"name" : @"user[name]",
     @"email" : @"user[email]",
     @"avatar" : @"user[avatar]",
     
     }];
    
    RKObjectMapping *authorizationMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [authorizationMapping addAttributeMappingsFromDictionary:@{
     @"uid" : @"uid",
     @"oauthToken" : @"oauth_token",
     @"provider" : @"provider",
     }];
    
    RKRelationshipMapping* relationShipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"authentications"
                                                                                             toKeyPath:@"oauth"
                                                                                           withMapping:authorizationMapping];
    [userMapping addPropertyMapping:relationShipMapping];
    
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:userMapping
                                                                                   objectClass:[CCUser class]
                                                                                   rootKeyPath:nil];
    [objectManager addRequestDescriptor:requestDescriptor];
}



@end
