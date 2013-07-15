//
//  CCUserNameHelper.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCUser;

@interface CCUserNameHelper : NSObject

+ (NSString *)fullNameOfUser:(CCUser *)user;

@end
