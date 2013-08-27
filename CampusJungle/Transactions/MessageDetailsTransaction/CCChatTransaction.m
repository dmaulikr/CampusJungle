//
//  CCMessageDetailsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCChatTransaction.h"
#import "CCMessageDetailsController.h"
#import "CCPrivateMessageTransaction.h"
#import "CCOtherUserProfileTransaction.h"
#import "CCChatController.h"

@implementation CCChatTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);

    CCChatController *chatController = [CCChatController new];
    chatController.dialog = object;
    
    
    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    otherUserProfileTransaction.navigation = self.navigation;
    chatController.otherUserProfileTransaction = otherUserProfileTransaction;
    
    [self.navigation pushViewController:chatController animated:YES];
}

@end
