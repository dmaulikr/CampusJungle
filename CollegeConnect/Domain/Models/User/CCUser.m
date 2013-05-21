//
//  CCUser.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUser.h"
#import "CCAuthorization.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation CCUser

+(CCUser*)userFromFacebookDictionary:(NSDictionary *)userDictionary
{
    CCUser* createdUser = [CCUser new];
    createdUser.name = userDictionary[@"name"];
    createdUser.email = userDictionary[@"email"];
    
    createdUser.avatar = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200",userDictionary[@"id"]];
    CCAuthorization *facebookAuthorization = [CCAuthorization new];
    
    facebookAuthorization.uid = userDictionary[@"id"];
    facebookAuthorization.provider = @"facebook";
    facebookAuthorization.oauthToken = [[[FBSession activeSession] accessTokenData] accessToken];
    createdUser.authorizations = @[facebookAuthorization];
    
    return createdUser;
}


@end
