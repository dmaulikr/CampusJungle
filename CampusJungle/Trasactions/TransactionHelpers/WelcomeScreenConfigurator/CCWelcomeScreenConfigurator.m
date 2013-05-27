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
#import "CCInitialUserProfileTransaction.h"

@implementation CCWelcomeScreenConfigurator

+ (UINavigationController *)configureWithBaseController:(CCMenuController *)menu
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
    
    CCInitialUserProfileTransaction *initialUserTransaction = [CCInitialUserProfileTransaction new];
    
    signUpTransaction.initialUserProfileTransaction = initialUserTransaction;
    
    initialUserTransaction.loginTransaction = loginTransaction;
    
    initialUserTransaction.baseViewController = menu;
    welcomeController.initialUserInfoTransaction = initialUserTransaction;
    
    loginScreenTransaction.loginTransaction = loginTransaction;
    loginScreenTransaction.navigation = navigation;
    welcomeController.loginScreenTransaction = loginScreenTransaction;
    return navigation;
}

@end
