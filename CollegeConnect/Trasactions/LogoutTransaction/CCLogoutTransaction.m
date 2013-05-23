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

@interface CCLogoutTransaction ()

@property (nonatomic, strong) id <CCFaceBookAPIProtocol> ioc_facebookAPI;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCLogoutTransaction

- (void)perform
{
    NSParameterAssert(self.rootMenuController);
    
    [self.ioc_facebookAPI logout];
    [self.ioc_userSession clearUserInfo];
   
    UINavigationController *navigation = [CCWelcomeScreenConfigurator configurateWithBaseConroller:self.rootMenuController];
    
    [self.rootMenuController presentViewController:navigation animated:YES completion:nil];
}

@end
