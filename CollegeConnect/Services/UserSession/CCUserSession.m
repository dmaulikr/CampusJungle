//
//  CCUserSession.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserSession.h"
#import "CCDefines.h"


@implementation CCUserSession

- (void)clearUserInfo
{
    self.currentUser = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CCUserDefines.currentUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveUser
{
    NSData *myEncodedUser = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedUser forKey:CCUserDefines.currentUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (CCUser*)loadSevedUser
{
    NSData *serializedUser = [[NSUserDefaults standardUserDefaults] objectForKey:CCUserDefines.currentUser];
    return (CCUser *)[NSKeyedUnarchiver unarchiveObjectWithData:serializedUser];
}

- (void)setCurrentUser:(CCUser *)currentUser
{
    _currentUser = currentUser;
    [self saveUser];
}

@end
