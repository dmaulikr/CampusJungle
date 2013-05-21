//
//  CCUserSession.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCUserSessionProtocol<AppleGuiceInjectable,AppleGuiceSingleton>

@property (nonatomic, strong) id user;

@end
