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
#import "CCClassController.h"
#import "CCClassesOfCollegeTransaction.h"
#import "CCDropboxAPIProviderProtocol.h"
#import "CCMarketTranasction.h"
#import "CCInboxController.h"
#import "CCInboxTransaction.h"
#import "CCOfferDetailsTransaction.h"
#import "CCPaymentServiceProtocol.h"
#import "CCPushNotificationsService.h"
#import "CCStuffMarketTransaction.h"
#import "CCBookMarketTransaction.h"
#import "CCNotesMarketTransaction.h"

@interface CCMainTransaction()

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxAPIProvider;
@property (nonatomic, strong) id <CCPaymentServiceProtocol> ioc_paymentService;

@end

@implementation CCMainTransaction

- (void)perform
{
    NSParameterAssert(self.window);
    
    [self.ioc_dropboxAPIProvider createSession];    
    [self.ioc_paymentService resendAllPayments];
    
    CCSideBarController *rootController = [[CCSideBarController alloc] init];
    rootController.shouldDelegateAutorotateToVisiblePanel = NO;
    self.window.rootViewController = rootController;
    CCSideMenuController *leftController = [[CCSideMenuController alloc] init];
	rootController.leftPanel = leftController;
    rootController.panningLimitedToTopViewController = NO;
    
    CCStuffMarketTransaction *stuffTransaction = [CCStuffMarketTransaction new];
    stuffTransaction.menuController = rootController;
    leftController.collegeMarketTransaction = stuffTransaction;
    
    CCBookMarketTransaction *bookTransaction = [CCBookMarketTransaction new];
    bookTransaction.menuController = rootController;
    leftController.booksTransaction = bookTransaction;
    
    CCNotesMarketTransaction *notesMarketTransaction = [CCNotesMarketTransaction new];
    notesMarketTransaction.menuController = rootController;
    leftController.notesTransaction = notesMarketTransaction;
    
    [self.ioc_userSession setCurrentUser: [self.ioc_userSession loadSavedUser]];
    
    CCUserProfileTransaction *userProfileTransaction = [CCUserProfileTransaction new];
    userProfileTransaction.menuController = rootController;
    leftController.userProfileTransaction = userProfileTransaction;
    
    CCClassesOfCollegeTransaction *classesOfCollegeTransaction = [CCClassesOfCollegeTransaction new];
    classesOfCollegeTransaction.menuController = rootController;
    leftController.classesOfCollegeTransaction = classesOfCollegeTransaction;
    
    CCInboxTransaction *inboxTransaction = [CCInboxTransaction new];
    inboxTransaction.menuController = rootController;
    leftController.inboxTransaction = inboxTransaction;
    classesOfCollegeTransaction.inboxTransaction = inboxTransaction;
    
    CCClassTransaction *classTransaction = [CCClassTransaction new];
    classTransaction.menuController = rootController;
    classTransaction.newsFeedTransaction = inboxTransaction;
    leftController.classTransaction = classTransaction;
    
    
    CCMarketTranasction *marketTransaction = [CCMarketTranasction new];
    marketTransaction.menuController = rootController;
    leftController.marketTransaction = marketTransaction;
    
    [inboxTransaction perform];
    
    if ([self.ioc_userSession currentUser]) {
        [CCPushNotificationsService registerForRemoteNotifications];
        
    }
    else {
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
