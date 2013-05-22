//
//  CCDefines.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct CCAPIDefines {
    __unsafe_unretained NSString *baseURL;
    __unsafe_unretained NSString *authorization;
    __unsafe_unretained NSString *signUp;
} CCAPIDefines;


extern const struct CCUserDefines {
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *avatar;
    __unsafe_unretained NSString *oauthToken;
    __unsafe_unretained NSString *uid;
    
    __unsafe_unretained NSString *facebookUID;
    __unsafe_unretained NSString *facebookToken;
    __unsafe_unretained NSString *facebook;
    
    __unsafe_unretained NSString *currentUser;
} CCUserDefines;

extern const struct CCUserSignUpKeys {
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *email;
    __unsafe_unretained NSString *password;
} CCUserSignUpKeys;