//
//  CCPrivateMessageTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPrivateMessageTransaction.h"
#import "CCPrivateMessageController.h"
#import "CCSuccessSendMessageTransaction.h"

@implementation CCPrivateMessageTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCPrivateMessageController *privateMessageController = [CCPrivateMessageController new];
    privateMessageController.recipient = object;
    
    CCSuccessSendMessageTransaction *successMessageSendTransaction = [CCSuccessSendMessageTransaction new];
    successMessageSendTransaction.navigation = self.navigation;
    privateMessageController.successMessageSendTransaction = successMessageSendTransaction;
    
    [self.navigation pushViewController:privateMessageController animated:YES];
}

@end
