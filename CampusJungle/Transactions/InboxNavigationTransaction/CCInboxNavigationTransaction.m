//
//  CCInboxNavigationTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInboxNavigationTransaction.h"
#import "CCInboxController.h"
#import "CCOfferDetailsTransaction.h"
#import "CCChatTransaction.h"

@implementation CCInboxNavigationTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCInboxController *inboxController = [CCInboxController new];
    
    CCOfferDetailsTransaction *offerDetails = [CCOfferDetailsTransaction new];
    offerDetails.navigation = self.navigation;
    inboxController.offerDetailsTransaction = offerDetails;
    
    CCChatTransaction *messageDetailsTransaction = [CCChatTransaction new];
    messageDetailsTransaction.navigation = self.navigation;
    inboxController.messageDetailsTransaction = messageDetailsTransaction;
    
    [self.navigation pushViewController:inboxController animated:YES];
    if (object) {
        NSInteger tabIndex = [[object valueForKey:@"selectedTabIndex"] integerValue];
        [inboxController selectTabAtIndex:tabIndex];
    }
}

@end
