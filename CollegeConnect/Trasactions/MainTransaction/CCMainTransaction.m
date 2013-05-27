//
//  CCMainTransaction.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMainTransaction.h"
#import "CCUserSessionProtocol.h"
#import "CCLogoutTransaction.h"
#import "CCWelcomeScreenConfigurator.h"
#import "CCUserProfile.h"
#import "CCUserProfileTransaction.h"

@interface CCMainTransaction()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMainTransaction

- (void)perform
{
    NSParameterAssert(self.window);
    
    CCMenuController *menu = [CCMenuController new];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:menu];
    
    [self.ioc_userSession setCurrentUser: [self.ioc_userSession loadSavedUser]];
    
    CCUserProfileTransaction *userProfileTransaction = [CCUserProfileTransaction new];
    userProfileTransaction.menuController = menu;
    
    menu.userProfileTransaction = userProfileTransaction;
    
        
    if ([self.ioc_userSession currentUser]){
        
    } else {
        [self showWelcomScreenIn:menu];
    }
}

- (void)showWelcomScreenIn:(CCMenuController *)menu
{

    __weak CCMenuController *weakMenu = menu;
    
    UINavigationController *navigation = [CCWelcomeScreenConfigurator configurateWithBaseConroller:menu];
    
    menu.blockOnViewDidAppear = ^{
        [weakMenu presentViewController:navigation animated:NO completion:nil];
    };

}

@end
