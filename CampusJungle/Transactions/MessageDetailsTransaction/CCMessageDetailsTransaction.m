//
//  CCMessageDetailsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessageDetailsTransaction.h"
#import "CCMessageDetailsController.h"
#import "CCPrivateMessageTransaction.h"
#import "CCOtherUserProfileTransaction.h"
#import "CCChatController.h"

@implementation CCMessageDetailsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCMessageDetailsController *messageDetailsController = [CCMessageDetailsController new];
    messageDetailsController.message = object;
    
    CCChatController *chatController = [CCChatController new];
    
    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    otherUserProfileTransaction.navigation = self.navigation;
    messageDetailsController.senderDetailsTransaction = otherUserProfileTransaction;
    
    CCPrivateMessageTransaction *privateMessageTransaction = [CCPrivateMessageTransaction new];
    privateMessageTransaction.navigation = self.navigation;
    messageDetailsController.replyTransaction = privateMessageTransaction;
    
    //[self.navigation pushViewController:messageDetailsController animated:YES];
    [self.navigation pushViewController:chatController animated:YES];
}

@end
