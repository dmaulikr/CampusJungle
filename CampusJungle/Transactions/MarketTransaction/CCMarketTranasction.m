//
//  CCMarketTranasction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketTranasction.h"
#import "CCMarketPlaceController.h"
#import "CCSelectFiltersTranaction.h"
#import "CCNoteDetailTransaction.h"
#import "CCViewMarketNotesListTransaction.h"
#import "CCViewMarketStuffListTransaction.h"
#import "CCStuffDetailsTransaction.h"
#import "CCStuffDetailsTransaction.h"

@implementation CCMarketTranasction

- (void)perform
{
    NSParameterAssert(self.menuController);
   
    CCMarketPlaceController *marketController = [CCMarketPlaceController new];
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:marketController];
    CCSelectFiltersTranaction *selectFilterTransaction = [CCSelectFiltersTranaction new];
    selectFilterTransaction.navigation = centralNavigation;
    marketController.filtersScreenTransaction = selectFilterTransaction;
    
    CCNoteDetailTransaction *noteDetails = [CCNoteDetailTransaction new];
    noteDetails.navigation = centralNavigation;
    marketController.noteDetailsTransaction = noteDetails;
    
    CCViewMarketNotesListTransaction *viewFullMarketListTransaction = [CCViewMarketNotesListTransaction new];
    viewFullMarketListTransaction.navigation = centralNavigation;
    
    marketController.fullListOfNotesTransaction = viewFullMarketListTransaction;
    
    CCViewMarketStuffListTransaction *viewStuffListTransaction = [CCViewMarketStuffListTransaction new];
    viewStuffListTransaction.navigation = centralNavigation;
    
    CCStuffDetailsTransaction *stuffDetails = [CCStuffDetailsTransaction new];
    stuffDetails.navigation = centralNavigation;    
    marketController.stuffDetailsTransaction = stuffDetails;

    marketController.fullListOfStuffTransaction = viewStuffListTransaction;
    [self.menuController setCenterPanel:centralNavigation];
}

@end
