//
//  CCBookDetalsTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBookDetalsTransaction.h"
#import "CCBookDetailsController.h"
#import "CCPhotoBrowserTransaction.h"
#import "CCOfferCreationTransaction.h"
#import "CCBooksOfferController.h"
#import "CCBackTransaction.h"
#import "CCBookOfferTransaction.h"

@implementation CCBookDetalsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCBookDetailsController *stuffDetailsController = [CCBookDetailsController new];
    stuffDetailsController.stuff = object;
    
    CCBookOfferTransaction *offerCreationTransaction = [CCBookOfferTransaction new];
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
