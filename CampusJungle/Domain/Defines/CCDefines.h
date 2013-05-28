//
//  CCDefines.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

extern const struct CCAPIDefines {
    __unsafe_unretained NSString *baseURL;
    __unsafe_unretained NSString *authorization;
    __unsafe_unretained NSString *signUp;
    __unsafe_unretained NSString *login;
} CCAPIDefines;


extern const struct CCUserDefines {
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *avatar;
    __unsafe_unretained NSString *oauthToken;
    __unsafe_unretained NSString *uid;
    
    __unsafe_unretained NSString *facebookUID;
    __unsafe_unretained NSString *facebookToken;
    __unsafe_unretained NSString *facebook;
    
    __unsafe_unretained NSString *currentUser;
    
    __unsafe_unretained NSString *facebookAvatarLinkTemplate;
} CCUserDefines;

extern const struct CCUserSignUpKeys {
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *password;
} CCUserSignUpKeys;

extern const struct CCUserAuthorizationKeys {
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *avatar;
    __unsafe_unretained NSString *authToken;
    __unsafe_unretained NSString *authProvider;
    __unsafe_unretained NSString *authUID;
} CCUserAuthorizationKeys;

extern const struct CCFacebookKeys {
    __unsafe_unretained NSString *uid;
    __unsafe_unretained NSString *firstName;
    __unsafe_unretained NSString *lastName;
    __unsafe_unretained NSString *email;
} CCFacebookKeys;