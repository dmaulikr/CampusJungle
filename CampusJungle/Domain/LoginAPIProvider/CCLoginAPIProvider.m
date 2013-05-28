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
#import "CCDefines.h"
#import "CCAuthorizationResponse.h"

@interface CCLoginAPIProvider ()

@property (nonatomic, strong) id <CCFaceBookAPIProtocol> ioc_facebookAPI;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCLoginAPIProvider

- (void)performLoginOperationViaTwitterWithUserInfo:(NSDictionary *)userDictionary SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    NSString *avatarURL = [(NSString *)userDictionary[@"auth"][@"info"][@"image"] componentsSeparatedByString:@"_normal"][0];
    avatarURL = [NSString stringWithFormat:@"%@.jpg",avatarURL];
    
    NSDictionary *userInfo = @{
                               CCUserAuthorizationKeys.firstName : userDictionary[@"auth"][@"info"][@"first_name"],
                               CCUserAuthorizationKeys.lastName : userDictionary[@"auth"][@"info"][@"last_name"],
                               CCUserAuthorizationKeys.avatar: avatarURL,
                               CCUserAuthorizationKeys.authToken:userDictionary[@"auth"][@"credentials"][@"token"],
                               CCUserAuthorizationKeys.authSecretToken : userDictionary[@"auth"][@"credentials"][@"secret"],
                               CCUserAuthorizationKeys.authUID : userDictionary[@"auth"][@"uid"],
                               CCUserAuthorizationKeys.authProvider: @"twitter"
                               };
    [self authorizeUserOnServerWithUserInfo:(NSDictionary *)userInfo SuccessHandler:successHandler errorHandler:errorHandler];
}

- (void)performLoginOperationWithUserInfo:(NSDictionary *)userInfo successHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
   [self.ioc_apiProvider putUserForLogin:userInfo
                          successHandler:^(RKMappingResult *result) {
       successHandler();
   } errorHandler:^(NSError *error) {
       errorHandler(error);
   }];
}

- (void)performLoginOperationViaFacebookWithSuccessHandler:(successWithObject)successHandler
                                              errorHandler:(errorHandler)errorHandler
{
    [self loginFacebookSuccessHandler:successHandler
                         errorHandler:errorHandler];
}

- (void)loginFacebookSuccessHandler:(successWithObject)successHandler
                       errorHandler:(errorHandler)errorHandler
{
    [self.ioc_facebookAPI logout];
    [self.ioc_facebookAPI loginWithSuccessHandler:^{
        [self getUserInfoSuccessHandler:successHandler
                           errorHandler:errorHandler];
    } errorHandler:^(NSError *error) {
        errorHandler(error);
    }];
}

- (void)getUserInfoSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_facebookAPI getUserInfoSuccessHandler:^(NSDictionary *userDictionary) {
        
        NSDictionary *userInfo = @{
                                   CCUserAuthorizationKeys.firstName : userDictionary[CCFacebookKeys.firstName],
                                   CCUserAuthorizationKeys.lastName : userDictionary[CCFacebookKeys.lastName],
                                   CCUserAuthorizationKeys.email: userDictionary[CCFacebookKeys.email],
                                   CCUserAuthorizationKeys.avatar: [NSString stringWithFormat:CCUserDefines.facebookAvatarLinkTemplate,userDictionary[CCFacebookKeys.uid]],
                                   CCUserAuthorizationKeys.authToken:[[[FBSession activeSession] accessTokenData] accessToken],
                                   CCUserAuthorizationKeys.authUID : userDictionary[CCFacebookKeys.uid],
                                   CCUserAuthorizationKeys.authProvider: CCUserDefines.facebook
                                   };
        [self authorizeUserOnServerWithUserInfo:(NSDictionary *)userInfo SuccessHandler:successHandler errorHandler:errorHandler];
    } errorHandler:^(NSError *error){
        errorHandler(error);
    }];
}

- (void)authorizeUserOnServerWithUserInfo:(NSDictionary *)userInfo SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_apiProvider putUser:userInfo
                   successHandler:^(RKMappingResult *result) {
        self.ioc_userSession.currentUser = [(CCAuthorizationResponse *)result.firstObject user];
        successHandler(result.firstObject);
    } errorHandler:^(RKObjectRequestOperation *operation, NSError *error) {
        errorHandler(error);
    }];
}

@end
