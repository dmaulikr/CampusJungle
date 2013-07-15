//
//  CCUserNameHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserNameHelper.h"
#import "CCUser.h"

@implementation CCUserNameHelper

+ (NSString *)fullNameOfUser:(CCUser *)user
{
    return [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
}

@end
