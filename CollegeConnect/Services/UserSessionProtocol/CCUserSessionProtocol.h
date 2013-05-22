//
//  CCUserSession.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUser.h"

@protocol CCUserSessionProtocol<AppleGuiceInjectable,AppleGuiceSingleton>

@property (nonatomic, strong) CCUser *currentUser;

- (CCUser*)loadSevedUser;

- (void)saveUser;

- (void)clearUserInfo;

@end
