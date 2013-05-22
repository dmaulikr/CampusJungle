//
//  CCSignUpAPIProvider.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSignUpAPIProvider.h"
#import "CCAPIProviderProtocol.h"


@interface CCSignUpAPIProvider()

@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_api_provider;

@end

@implementation CCSignUpAPIProvider

- (void)signUpWithUserDictionary:(NSDictionary *)userInfo successHandler:(successHandler)success errorHandler:(errorHandler)errorHandler
{
    [self.ioc_api_provider putUserForSingUp:userInfo successHandler:^(RKMappingResult *result) {
        
    } errorHandler:^(NSError * error) {
        errorHandler(error);
    }];
}

@end
