//
//  CCMainTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMainTransaction.h"
#import "CCLoginController.h"
#import "CCUserSessionProtocol.h"
#import "CCMenuController.h"
#import "CCLoginTransaction.h"
#import "CCSignUpTransaction.h"

@interface CCMainTransaction()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMainTransaction

- (void)perform
{
    NSParameterAssert(self.window);
    
    
    CCMenuController *menu = [CCMenuController new];
    
    self.window.rootViewController = menu;
    [self.ioc_userSession setCurrentUser: [self.ioc_userSession loadSevedUser]];
    
    [CCLoginController new];
    
    if ([self.ioc_userSession currentUser]){
        
    } else {
        CCLoginTransaction *loginTransaction = [CCLoginTransaction new];
        loginTransaction.menuController = menu;
        
        CCSignUpTransaction *signUpTransaction = [CCSignUpTransaction new];
       
        
        CCLoginController *loginController = [CCLoginController new];
        loginController.loginTransaction = loginTransaction;
        loginController.signUpTransaction = signUpTransaction;
        
        UINavigationController* navigation = [[UINavigationController alloc]initWithRootViewController:loginController];
        
        signUpTransaction.navigation = navigation;
        
        __weak CCMenuController *weakMenu = menu;
        menu.blockOnViewDidAppear = ^{
            [weakMenu presentViewController:navigation animated:NO completion:nil];
        };
    }
}

@end
