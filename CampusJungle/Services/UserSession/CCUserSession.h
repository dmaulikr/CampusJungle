//
//  CCUserSession.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUserSessionProtocol.h"
#import "CCUser.h"

@interface CCUserSession : NSObject<CCUserSessionProtocol>

@property (nonatomic, strong) CCUser *currentUser;

@end
