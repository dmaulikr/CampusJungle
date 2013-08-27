//
//  CCOtherUserProfileTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOtherUserProfileTransaction.h"
#import "CCOtherUserProfileController.h"
#import "CCPrivateMessageTransaction.h"
#import "CCInboxTransaction.h"
#import "CCPushToClassControllerTransaction.h"
#import "CCChatTransaction.h"

@implementation CCOtherUserProfileTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    CCOtherUserProfileController *otherUserProfileController = [CCOtherUserProfileController new];
    otherUserProfileController.currentUser = object;

    CCPrivateMessageTransaction *privateMessageTransaction = [CCPrivateMessageTransaction new];
    privateMessageTransaction.navigation = self.navigation;
    otherUserProfileController.sendMessageTransaction = privateMessageTransaction;
    
    CCInboxTransaction *inboxTransaction = [CCInboxTransaction new];
    inboxTransaction.menuController = (JASidePanelController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    CCPushToClassControllerTransaction *pushToClassTransaction = [CCPushToClassControllerTransaction new];
    
    CCChatTransaction *chatTranasaction = [CCChatTransaction new];
    chatTranasaction.navigation = self.navigation;
    otherUserProfileController.chatTransaction = chatTranasaction;
    
    pushToClassTransaction.inboxTransaction = inboxTransaction;
    pushToClassTransaction.navigation = self.navigation;
    otherUserProfileController.classTransaction = pushToClassTransaction;
    
    
    [self.navigation pushViewController:otherUserProfileController animated:YES];

}

@end
