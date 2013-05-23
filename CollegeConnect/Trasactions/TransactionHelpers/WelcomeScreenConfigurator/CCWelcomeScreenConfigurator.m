//
//  CCWelcomeScreenConfigurator.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCWelcomeScreenConfigurator.h"
#import "CCWelcomeController.h"
#import "CCLoginTransaction.h"
#import "CCLoginScreenTransaction.h"
#import "CCSignUpTransaction.h"
#import "CCInitialUserInfoTransaction.h"

@implementation CCWelcomeScreenConfigurator

+ (UINavigationController *)configurateWithBaseConroller:(CCMenuController *)menu
{
    CCWelcomeController *welcomeController = [CCWelcomeController new];
    
    UINavigationController* navigation = [[UINavigationController alloc]initWithRootViewController:welcomeController];
    
    CCLoginTransaction *loginTransaction = [CCLoginTransaction new];
    loginTransaction.menuController = menu;
    welcomeController.loginTransaction = loginTransaction;
    
    CCSignUpTransaction *signUpTransaction = [CCSignUpTransaction new];
    
    signUpTransaction.navigation = navigation;
    welcomeController.signUpTransaction = signUpTransaction;
    
    CCLoginScreenTransaction *loginScreenTransaction = [CCLoginScreenTransaction new];
    
    CCInitialUserInfoTransaction *initialUserTransaction = [CCInitialUserInfoTransaction new];
    
    signUpTransaction.initialUserInfoTransaction = initialUserTransaction;
    
    initialUserTransaction.navigation = navigation;
    initialUserTransaction.loginTransaction = loginTransaction;
    
    loginScreenTransaction.loginTransaction = loginTransaction;
    loginScreenTransaction.navigation = navigation;
    welcomeController.loginScreenTransaction = loginScreenTransaction;
    return navigation;
}

@end
