//
//  CCInboxTransAction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInboxTransaction.h"
#import "CCInboxController.h"
#import "CCOfferDetailsTransaction.h"
#import "CCChatTransaction.h"

@implementation CCInboxTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    
    CCInboxController *inboxController = [CCInboxController new];
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:inboxController];
    
    CCOfferDetailsTransaction *offerDetails = [CCOfferDetailsTransaction new];
    offerDetails.navigation = centralNavigation;
    inboxController.offerDetailsTransaction = offerDetails;
    
    CCChatTransaction *messageDetailsTransaction = [CCChatTransaction new];
    messageDetailsTransaction.navigation = centralNavigation;
    inboxController.messageDetailsTransaction = messageDetailsTransaction;
    
    [self.menuController setCenterPanel:centralNavigation];
}

@end
