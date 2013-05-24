//
//  CCDefines.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDefines.h"

const struct CCAPIDefines CCAPIDefines = {
    .baseURL = @"http://collegeconnect.111projects.com",
    .signUp = @"/api/users/sign_up",
    .authorization = @"/api/authentications",
    .login = @"/api/users/login",
};


const struct CCUserDefines CCUserDefines = {
    .firstName = @"UserFirstName",
    .lastName = @"UserLastName",
    .email = @"UserEmail",
    .avatar = @"UserAvatar",
    .oauthToken = @"UserOauthToken",
    .uid = @"UserUID",
    
    .facebookUID = @"FacebookUID",
    .facebookToken = @"FacebookToken",
    .facebook = @"facebook",
    
    .currentUser = @"current_user",
};

const struct CCUserSignUpKeys CCUserSignUpKeys = {
    .firstName = @"first_name",
    .lastName = @"last_name",
    .email = @"email",
    .password = @"password"
};