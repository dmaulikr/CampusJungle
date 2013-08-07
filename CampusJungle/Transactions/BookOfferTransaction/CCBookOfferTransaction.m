//
//  CCBookOfferTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBookOfferTransaction.h"
#import "CCBooksOfferController.h"
#import "CCBackToStuffTransaction.h"

@implementation CCBookOfferTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCBooksOfferController *bookOfferController = [CCBooksOfferController new];
    bookOfferController.currentStuff = object;
    CCBackToStuffTransaction *backToStuffTransaction = [CCBackToStuffTransaction new];
    backToStuffTransaction.navigation = self.navigation;
    bookOfferController.backToStuffTransaction = backToStuffTransaction;
    [self.navigation pushViewController:bookOfferController animated:YES];

}

@end
