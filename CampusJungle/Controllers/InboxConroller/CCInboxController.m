//
//  CCInboxControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInboxController.h"
#import "CCOffersDataProvider.h"
#import "CCOrdinaryCell.h"
#import "CCOffer.h"
#import "CCMessage.h"
#import "CCMessagesDataProvider.h"

@interface CCInboxController ()

@end

@implementation CCInboxController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Inbox";
    CCMessagesDataProvider *messagesDataProvider = [CCMessagesDataProvider new];
    messagesDataProvider.filters = @{
                                     @"personal" : @"YES"
                                     };
    [self configTableWithProvider:messagesDataProvider cellClass:[CCOrdinaryCell class]];
   // [self configTableWithProvider:[CCOffersDataProvider new] cellClass:[CCOrdinaryCell class]];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCOffer class]]){
        [self.offerDetailsTransaction performWithObject:cellObject];
    } else if ([cellObject isKindOfClass:[CCMessage class]]){
        
    }
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
