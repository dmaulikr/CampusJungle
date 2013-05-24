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

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.firstName forKey:CCUserDefines.firstName];
    [encoder encodeObject:self.lastName forKey:CCUserDefines.lastName];
    [encoder encodeObject:self.token forKey:CCUserDefines.oauthToken];
    [encoder encodeObject:self.uid forKey:CCUserDefines.uid];
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
        self.firstName = [decoder decodeObjectForKey:CCUserDefines.firstName];
        self.lastName = [decoder decodeObjectForKey:CCUserDefines.lastName];
        self.token = [decoder decodeObjectForKey:CCUserDefines.oauthToken];
        self.uid = [decoder decodeObjectForKey:CCUserDefines.uid];
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
