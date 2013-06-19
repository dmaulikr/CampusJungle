//
//  CCUserSession.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserSession.h"
#import "CCDefines.h"
#import "CCTypesDefinition.h"
#import "CCAPIProviderProtocol.h"

@interface CCUserSession()

@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@end

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

- (CCUser*)loadSavedUser
{
    NSData *serializedUser = [[NSUserDefaults standardUserDefaults] objectForKey:CCUserDefines.currentUser];
    return (CCUser *)[NSKeyedUnarchiver unarchiveObjectWithData:serializedUser];
}

- (void)setCurrentUser:(CCUser *)currentUser
{
    if(!currentUser.token){
        currentUser.token = _currentUser.token;
        currentUser.isFacebookLinked = currentUser.isFacebookLinked;
    }
    if(!currentUser.token){
        currentUser.token = _currentUser.token;
    }
    _currentUser = currentUser;
    [self saveUser];
}

- (void)loadUserEducationsSuccessHandler:(successWithObject)success
{
    CCUser *user = [self currentUser];
    if(user.educations){
        success(user.educations);
    } else {
        [self.ioc_apiProvider loadUserInfoSuccessHandler:^(id result) {
            [self setCurrentUser:result];
            success(user.educations);
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }
}

@end
