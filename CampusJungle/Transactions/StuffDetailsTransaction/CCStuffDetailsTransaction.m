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
#import "CCBackTransaction.h"

@implementation CCStuffDetailsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCStuffDetailsController *stuffDetailsController = [CCStuffDetailsController new];
    stuffDetailsController.stuff = object;
    
    CCOfferCreationTransaction *offerCreationTransaction = [CCOfferCreationTransaction new];
    offerCreationTransaction.navigation = self.navigation;
    
    CCPhotoBrowserTransaction *photoBrowserTransaction = [CCPhotoBrowserTransaction new];
    photoBrowserTransaction.navigation = self.navigation;
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    stuffDetailsController.photoBrowserTransaction = photoBrowserTransaction;
    stuffDetailsController.backTransaction = backTransaction;
    stuffDetailsController.createOfferTarnasaction = offerCreationTransaction;
    [self.navigation pushViewController:stuffDetailsController animated:YES];
    
}

@end
