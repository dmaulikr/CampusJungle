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
#import "CCMessageCell.h"
#import "CCOfferCell.h"
#import "CCUserSessionProtocol.h"

#define MessagesState 0
#define InvtesState 1
#define OffersState 2

@interface CCInboxController ()

- (IBAction)segmentedControlDidChangeValue:(UISegmentedControl *)control;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCInboxController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Inbox";
    CCMessagesDataProvider *messagesDataProvider = [CCMessagesDataProvider new];
    messagesDataProvider.filters = @{
                                     @"personal" : @"YES",
                                     @"direction" : @"received"
                                     };
    if([self.ioc_userSession currentUser]){
        [self configTableWithProvider:messagesDataProvider cellClass:[CCMessageCell class] cellReuseIdentifier:NSStringFromClass([CCMessageCell class])];
    }
    self.mainTable.tableFooterView = [UIView new];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCOffer class]]){
        [self.offerDetailsTransaction performWithObject:cellObject];
    } else if ([cellObject isKindOfClass:[CCMessage class]]){
        [self.messageDetailsTransaction performWithObject:cellObject];
    }
}

- (IBAction)segmentedControlDidChangeValue:(UISegmentedControl *)control
{
    switch (control.selectedSegmentIndex) {
        case MessagesState:{
            [self setMessagesConfiguration];
        } break;
        case InvtesState:{
            [self setInvitesConfiguration];
        } break;
        case OffersState:{
            [self setOfferConfiguration];
        } break;
    }
}

- (void)setInvitesConfiguration
{
    [self.mainTable reloadData];
}

- (void)setMessagesConfiguration
{
    CCMessagesDataProvider *messagesDataProvider = [CCMessagesDataProvider new];
    messagesDataProvider.filters = @{
                                     @"personal" : @"YES",
                                    @"direction" : @"received"
                                     };
    [self configTableWithProvider:messagesDataProvider cellClass:[CCMessageCell class] cellReuseIdentifier:NSStringFromClass([CCMessageCell class])];
    [self.mainTable reloadData];
}

- (void)setOfferConfiguration
{
    [self configTableWithProvider:[CCOffersDataProvider new] cellClass:[CCOfferCell class] cellReuseIdentifier:NSStringFromClass([CCOffer class])];
    [self.mainTable reloadData];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

@end
