//
//  CCStuffDetailsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffDetailsTransaction.h"
#import "CCStuffDetailsController.h"
#import "CCPhotoBrowserTransaction.h"
#import "CCOfferCreationTransaction.h"
#import "CCRateControllerTransaction.h"

@implementation CCStuffDetailsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCStuffDetailsController *stuffDetailsController = [CCStuffDetailsController new];
    stuffDetailsController.stuff = object;
    
    CCOfferCreationTransaction *offerCreationTransaction = [CCOfferCreationTransaction new];
    offerCreationTransaction.navigation = self.navigation;
    stuffDetailsController.createOfferTarnasaction = offerCreationTransaction;
    
    CCPhotoBrowserTransaction *photoBrowserTransaction = [CCPhotoBrowserTransaction new];
    photoBrowserTransaction.navigation = self.navigation;
    
    CCRateControllerTransaction *rateControllerTransaction = [CCRateControllerTransaction new];
    rateControllerTransaction.navigation = self.navigation;
    stuffDetailsController.rateTransaction = rateControllerTransaction;
    
    stuffDetailsController.photoBrowserTransaction = photoBrowserTransaction;
    [self.navigation pushViewController:stuffDetailsController animated:YES];
    
}

@end
