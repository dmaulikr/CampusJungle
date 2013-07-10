//
//  CCOfferDetailsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOfferDetailsTransaction.h"
#import "CCOfferDetailsController.h"
#import "CCOtherUserProfileTransaction.h"
#import "CCStuffDetailsTransaction.h"
#import "CCPrivateMessageTransaction.h"

@implementation CCOfferDetailsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCOfferDetailsController *offerDetails = [CCOfferDetailsController new];
    
    CCOtherUserProfileTransaction *otherUserProfileTransaction = [CCOtherUserProfileTransaction new];
    otherUserProfileTransaction.navigation = self.navigation;
    offerDetails.senderDetailsTransaction = otherUserProfileTransaction;
    
    CCStuffDetailsTransaction *stuffDetailsTransaction = [CCStuffDetailsTransaction new];
    stuffDetailsTransaction.navigation = self.navigation;
    offerDetails.stuffDetailsTransaction = stuffDetailsTransaction;
    
    offerDetails.offer = object;
    
    CCPrivateMessageTransaction *privateMessageTransaction = [CCPrivateMessageTransaction new];
    privateMessageTransaction.navigation = self.navigation;
    offerDetails.answerTransaction = privateMessageTransaction;
    
    [self.navigation pushViewController:offerDetails animated:YES];
}

@end