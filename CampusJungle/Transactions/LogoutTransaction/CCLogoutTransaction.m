//
//  CCLogoutTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLogoutTransaction.h"
#import "CCFaceBookAPIProtocol.h"
#import "CCUserSessionProtocol.h"
#import "CCWelcomeScreenConfigurator.h"
#import "CCDropboxAPIProviderProtocol.h"

@interface CCLogoutTransaction ()

@property (nonatomic, strong) id <CCFaceBookAPIProtocol> ioc_facebookAPI;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPI;

@end

@implementation CCLogoutTransaction

- (void)perform
{
    NSParameterAssert(self.rootMenuController);
    
    [self.ioc_facebookAPI logout];
    [self.ioc_dropboxAPI unlink];
    [self.ioc_userSession clearUserInfo];
   
    UINavigationController *navigation = [CCWelcomeScreenConfigurator configureWithBaseController:self.rootMenuController];
    
    [self.rootMenuController presentViewController:navigation animated:YES completion:nil];
}

@end
