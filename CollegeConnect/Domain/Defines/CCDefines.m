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
    //.baseURL = @"http://172.17.18.4:3000",
    .authorization = @"api/authentications"
};


const struct CCUserDefines CCUserDefines = {
    .name = @"UserName",
    .email = @"UserEmail",
    .avatar = @"UserAvatar",
    .oauthToken = @"UserOauthToken",
    .uid = @"UserUID",
    
    .facebookUID = @"FacebookUID",
    .facebookToken = @"FacebookToken",
    .facebook = @"facebook",
    
    .currentUser = @"current_user",
};