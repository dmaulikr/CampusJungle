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
    
    [self.navigation pushViewController:otherUserProfileController animated:YES];

}

@end
