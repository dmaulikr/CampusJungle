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
#import "CCDefines.h"

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
    createdUser.authentications = @[facebookAuthorization];
    
    return createdUser;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.name forKey:CCUserDefines.name];
    [encoder encodeObject:self.token forKey:CCUserDefines.oauthToken];
    [encoder encodeObject:self.UID forKey:CCUserDefines.uid];
    [encoder encodeObject:self.avatar forKey:CCUserDefines.avatar];
    [encoder encodeObject:self.email forKey:CCUserDefines.email];
    
    CCAuthorization *facebookOAUTH;
    
    for (CCAuthorization *auth in self.authentications){
        if ([auth.provider isEqualToString:CCUserDefines.facebook]){
            facebookOAUTH = auth;
        }
    }
    [encoder encodeObject:facebookOAUTH.oauthToken forKey:CCUserDefines.facebookToken];
    [encoder encodeObject:facebookOAUTH.uid forKey:CCUserDefines.facebookUID];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.name = [decoder decodeObjectForKey:CCUserDefines.name];
        self.token = [decoder decodeObjectForKey:CCUserDefines.oauthToken];
        self.UID = [decoder decodeObjectForKey:CCUserDefines.uid];
        self.avatar = [decoder decodeObjectForKey:CCUserDefines.avatar];
        self.email = [decoder decodeObjectForKey:CCUserDefines.email];
        
        CCAuthorization *facebookOAUTH = [CCAuthorization new];
        if([decoder decodeObjectForKey:CCUserDefines.facebookUID]){
            facebookOAUTH.uid = [decoder decodeObjectForKey:CCUserDefines.facebookUID];
            facebookOAUTH.oauthToken = [decoder decodeObjectForKey:CCUserDefines.facebookToken];
            facebookOAUTH.provider = CCUserDefines.facebook;
            self.authentications = @[facebookOAUTH];
        }
    }
    
    return self;
}



@end
