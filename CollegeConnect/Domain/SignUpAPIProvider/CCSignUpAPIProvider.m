//
//  CCSignUpAPIProvider.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSignUpAPIProvider.h"
#import "CCAPIProviderProtocol.h"
#import "CCUserSessionProtocol.h"

@interface CCSignUpAPIProvider()

@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_api_provider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCSignUpAPIProvider

- (void)signUpWithUserDictionary:(NSDictionary *)userInfo successHandler:(successHandler)success errorHandler:(errorHandler)errorHandler
{
    [self.ioc_api_provider putUserForSingUp:userInfo successHandler:^(RKMappingResult *result) {
    
        self.ioc_userSession.currentUser = [result.firstObject user];
        success();
    } errorHandler:^(NSError * error) {
        errorHandler(error);
    }];
}

@end
