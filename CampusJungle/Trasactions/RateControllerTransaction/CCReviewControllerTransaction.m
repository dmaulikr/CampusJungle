//
//  CCRateControllerTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReviewControllerTransaction.h"
#import "CCReviewController.h"
#import "CCBackToNoteTransaction.h"

@implementation CCReviewControllerTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCReviewController *reviewController = [CCReviewController new];
    reviewController.note = object;
    
    CCBackToNoteTransaction *backToNoteTransaction = [CCBackToNoteTransaction new];
    backToNoteTransaction.navigation = self.navigation;
    
    reviewController.backToNoteTransaction = backToNoteTransaction;
    
    [self.navigation pushViewController:reviewController animated:YES];
}

@end
