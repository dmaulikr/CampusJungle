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
#import "CCSideBarController.h"
#import "CCClassTransaction.h"
#import "CCClassViewController.h"

@interface CCMainTransaction()
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCMainTransaction

- (void)perform
{
    NSParameterAssert(self.window);
    
    CCSideBarController *rootController = [[CCSideBarController alloc] init];
    rootController.shouldDelegateAutorotateToVisiblePanel = NO;
    
    CCSideMenuController *leftController = [[CCSideMenuController alloc] init];
	rootController.leftPanel = leftController;
    rootController.panningLimitedToTopViewController = NO;
    
    CCClassViewController *centralPanel = [CCClassViewController new];
    rootController.centerPanel = [[UINavigationController alloc] initWithRootViewController:centralPanel];

    self.window.rootViewController = rootController;
    
    [self.ioc_userSession setCurrentUser: [self.ioc_userSession loadSavedUser]];
    
    CCUserProfileTransaction *userProfileTransaction = [CCUserProfileTransaction new];
    userProfileTransaction.menuController = rootController;
    leftController.userProfileTransaction = userProfileTransaction;
    
    CCClassTransaction *classTransaction = [CCClassTransaction new];
    classTransaction.menuController = rootController;
    leftController.classTransaction = classTransaction;
        
    if ([self.ioc_userSession currentUser]){
        
    } else {
        [self showWelcomeScreenIn:rootController];
    }
}

- (void)showWelcomeScreenIn:(CCSideBarController *)sidePanel
{
    __weak CCSideBarController *__sidePanel = sidePanel;
        
    UINavigationController *navigation = [CCWelcomeScreenConfigurator configureWithBaseController:sidePanel];
    
    sidePanel.blockOnViewDidAppear = ^{
        [__sidePanel presentViewController:navigation animated:NO completion:nil];
    };

}

@end
