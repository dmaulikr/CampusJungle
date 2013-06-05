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
    NSArray *avatarNameParts = [(NSString *)userDictionary[CCTwitterUserKeys.auth][CCTwitterUserKeys.info][CCTwitterUserKeys.avatar] componentsSeparatedByString:@"_normal"];
    NSString *avatarURL = [NSString stringWithFormat:@"%@%@",avatarNameParts[0],avatarNameParts[1]];
    
    NSDictionary *userInfo = @{
                               CCUserAuthorizationKeys.firstName : userDictionary[CCTwitterUserKeys.auth][CCTwitterUserKeys.info][CCTwitterUserKeys.firstName],
                               CCUserAuthorizationKeys.lastName : userDictionary[CCTwitterUserKeys.auth][CCTwitterUserKeys.info][CCTwitterUserKeys.lastName],
                               CCUserAuthorizationKeys.avatar: avatarURL,
                               CCUserAuthorizationKeys.authToken:userDictionary[CCTwitterUserKeys.auth][CCTwitterUserKeys.credentials][CCTwitterUserKeys.token],
                               CCUserAuthorizationKeys.authSecretToken : userDictionary[CCTwitterUserKeys.auth][CCTwitterUserKeys.credentials][CCTwitterUserKeys.secret],
                               CCUserAuthorizationKeys.authUID : userDictionary[CCTwitterUserKeys.auth][CCTwitterUserKeys.uid],
                               CCUserAuthorizationKeys.authProvider: CCTwitterUserKeys.twitter
                               };
    [self authorizeUserOnServerWithUserInfo:(NSDictionary *)userInfo SuccessHandler:successHandler errorHandler:errorHandler];
}

- (void)performLoginOperationWithUserInfo:(NSDictionary *)userInfo successHandler:(successHandler)successHandler errorHandler:(errorHandler)errorHandler
{
   [self.ioc_apiProvider putUserForLogin:userInfo
                          successHandler:^(RKMappingResult *result) {
                              self.ioc_userSession.currentUser = [(CCAuthorizationResponse *)result.firstObject user];
       successHandler();
   } errorHandler:^(NSError *error) {
       errorHandler(error);
   }];
}

- (void)performLoginOperationViaFacebookWithSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler facebookSessionCreate:(successHandler)reactionOnFacebookSessionCreate
{
    [self loginFacebookSuccessHandler:successHandler
                         errorHandler:errorHandler
                facebookSessionCreate:reactionOnFacebookSessionCreate];
}

- (void)loginFacebookSuccessHandler:(successWithObject)successHandler
                       errorHandler:(errorHandler)errorHandler
              facebookSessionCreate:(successHandler)reactionOnFacebookSessionCreate
                       
{
    [self.ioc_facebookAPI logout];
    [self.ioc_facebookAPI loginWithSuccessHandler:^{
        reactionOnFacebookSessionCreate();
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

- (void)linkWithFacebookSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler facebookSessionCreate:(successHandler)reactionOnFacebookSessionCreate
{
    [self.ioc_facebookAPI logout];
    [self.ioc_facebookAPI loginWithSuccessHandler:^{
        reactionOnFacebookSessionCreate();
        [self fetchUserInfoForLinkingFromFacebookSuccessHandler:successHandler errorHandler:errorHandler];
    } errorHandler:^(NSError *error) {
        errorHandler(error);
    }];
}

- (void)fetchUserInfoForLinkingFromFacebookSuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_facebookAPI getUserInfoSuccessHandler:^(NSDictionary *userDictionary) {
        
        NSDictionary *userInfo = @{
                                   CCFacebookKeys.firstName : userDictionary[CCFacebookKeys.firstName],
                                   CCFacebookKeys.lastName : userDictionary[CCFacebookKeys.lastName],
                                   CCFacebookKeys.email : userDictionary[CCFacebookKeys.email],
                                   CCLinkUserKeys.oauth_token:[[[FBSession activeSession] accessTokenData] accessToken],
                                   CCLinkUserKeys.uid : userDictionary[CCFacebookKeys.uid],
                                   CCLinkUserKeys.provider: CCUserDefines.facebook
                                   };
        [self linkUserWithUserInfo:(NSDictionary *)userInfo SuccessHandler:successHandler errorHandler:errorHandler];
    } errorHandler:^(NSError *error){
        errorHandler(error);
    }];
}

- (void)linkUserWithUserInfo:(NSDictionary *)userInfo SuccessHandler:(successWithObject)successHandler errorHandler:(errorHandler)errorHandler
{
    [self.ioc_apiProvider linkUserWithUserInfo:userInfo successHandler:successHandler errorHandler:errorHandler];
}

@end
