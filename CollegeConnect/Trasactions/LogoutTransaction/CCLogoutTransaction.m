//
//  CCLogoutTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLogoutTransaction.h"
#import "CCWelcomeController.h"
#import "CCLoginTransaction.h"
#import "CCLoginScreenTransaction.h"
#import "CCSignUpTransaction.h"
#import "CCFaceBookAPIProtocol.h"
#import "CCUserSessionProtocol.h"

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
    
    CCWelcomeController *welcomeController = [CCWelcomeController new];
    
    UINavigationController* navigation = [[UINavigationController alloc]initWithRootViewController:welcomeController];
    
    CCLoginTransaction *loginTransaction = [CCLoginTransaction new];
    loginTransaction.menuController = self.rootMenuController;
    welcomeController.loginTransaction = loginTransaction;
    
    CCSignUpTransaction *signUpTransaction = [CCSignUpTransaction new];
    signUpTransaction.loginTransaction = loginTransaction;
    signUpTransaction.navigation = navigation;
    welcomeController.signUpTransaction = signUpTransaction;
    
    CCLoginScreenTransaction *loginScreenTransaction = [CCLoginScreenTransaction new];
    loginScreenTransaction.loginTransaction = loginTransaction;
    loginScreenTransaction.navigation = navigation;
    welcomeController.loginScreenTransaction = loginScreenTransaction;
    
    [self.rootMenuController presentViewController:navigation animated:YES completion:nil];
}

@end
