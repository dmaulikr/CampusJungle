//
//  CCLoginAPIProvider.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginAPIProvider.h"
#import "CCFaceBookAPIProtocol.h"
#import "CCUserSessionProtocol.h"
#import "CCAPIProviderProtocol.h"
#import <FacebookSDK/FacebookSDK.h>
#import "CCAuthorizationResponse.h"

@interface CCLoginAPIProvider ()

@property (nonatomic, strong) id <CCFaceBookAPIProtocol> ioc_facebookAPI;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCLoginAPIProvider

- (void)performLoginOperationWithUserInfo:(NSDictionary *)userInfo successHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
   [self.ioc_apiProvider putUserForLogin:userInfo successHandler:^(RKMappingResult *result) {
       successHandler();
   } errorHandler:^(NSError *error) {
       errorHandler(error);
   }];
}

- (void)performLoginOperationViaFacebookWithSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    [self loginFacebookSuccessHandler:successHandler errorHandler:errorHandler];
}

- (void)loginFacebookSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_facebookAPI loginWithSuccessHandler:^{
        [self getUserInfoSuccessHandler:successHandler errorHandler:errorHandler];
    } errorHandler:^(NSError *error) {
        errorHandler(error);
    }];
}

- (void)getUserInfoSuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_facebookAPI getUserInfoSuccessHandler:^(NSDictionary *userDictionary) {
        
        NSDictionary *userInfo = @{
                                   @"user[name]" : userDictionary[@"name"],
                                   @"user[email]": userDictionary[@"email"],
                                   @"user[avatar]": [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200",userDictionary[@"id"]],
                                   @"oauth[][oauth_token]":[[[FBSession activeSession] accessTokenData] accessToken],
                                   @"oauth[][uid]" : userDictionary[@"id"],
                                   @"oauth[][provider]": @"facebook"
                                   };
        [self authorizeUserOnServerWithUserInfo:(NSDictionary *)userInfo SuccessHandler:successHandler errorHandler:errorHandler];
    } errorHandler:^(NSError *error){
        errorHandler(error);
    }];
}

- (void)authorizeUserOnServerWithUserInfo:(NSDictionary *)userInfo SuccessHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_apiProvider putUser:userInfo successHandler:^(RKMappingResult * result) {
        self.ioc_userSession.currentUser = [(CCAuthorizationResponse *)result.firstObject user];
        successHandler();
    } errorHandler:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
