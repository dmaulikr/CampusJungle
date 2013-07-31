//
//  CCUserSession.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUser.h"
#import "CCStandardErrorHandler.h"
#import "CCTypesDefinition.h"

@protocol CCUserSessionProtocol<AppleGuiceInjectable,AppleGuiceSingleton>

@property (nonatomic, strong) CCUser *currentUser;
@property (nonatomic, strong) NSString *deviceToken;

- (CCUser*)loadSavedUser;

- (void)saveUser;

- (void)clearUserInfo;

- (void)loadUserEducationsSuccessHandler:(successWithObject)success;

@end
