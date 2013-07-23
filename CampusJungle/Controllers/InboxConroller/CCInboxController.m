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
#import "CCMessageAPIProviderProtocol.h"
#import "CCAlertHelper.h"

#define MessagesState 0
#define InvtesState 1
#define OffersState 2

@interface CCInboxController () <CCMessageCellDelegate>

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id<CCMessageAPIProviderProtocol> ioc_messagesApiProvider;
@property (nonatomic, strong) CCMessagesDataProvider *messagesDataProvider;
@property (nonatomic, strong) CCOffersDataProvider *offersDataProvider;

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
    if ([cellObject isKindOfClass:[CCOffer class]]) {
        [self.offerDetailsTransaction performWithObject:cellObject];
    }
    else if ([cellObject isKindOfClass:[CCMessage class]]) {
        [self.messageDetailsTransaction performWithObject:cellObject];
    }
}

- (IBAction)segmentedControlDidChangeValue:(UISegmentedControl *)control
{
    switch (control.selectedSegmentIndex) {
        case MessagesState:{
            [self setMessagesConfiguration];
            break;
        }
        case InvtesState:{
            [self setInvitesConfiguration];
            break;
        }
        case OffersState:{
            [self setOfferConfiguration];
            break;
        }
    }
}

- (void)setInvitesConfiguration
{
    [self.mainTable reloadData];
}

- (void)setMessagesConfiguration
{
    if (!self.messagesDataProvider) {
        self.messagesDataProvider = [CCMessagesDataProvider new];
        self.messagesDataProvider.filters = @{@"personal" : @"YES", @"direction" : @"received"};
    }
    [self configTableWithProvider:self.messagesDataProvider cellClass:[CCMessageCell class] cellReuseIdentifier:NSStringFromClass([CCMessageCell class])];
}

- (void)setOfferConfiguration
{
    if (!self.offersDataProvider) {
        self.offersDataProvider = [CCOffersDataProvider new];
    }
    [self configTableWithProvider:self.offersDataProvider cellClass:[CCOfferCell class] cellReuseIdentifier:NSStringFromClass([CCOffer class])];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

#pragma mark -
#pragma mark CCMessageCellDelegate
- (void)deleteMessage:(CCMessage *)message
{
    __weak CCInboxController *weakSelf = self;
    [CCAlertHelper showWithMessage:CCAlertsMessages.deleteMessage success:^{
        [weakSelf.ioc_messagesApiProvider deleteMessageWithId:message.messageID successHandler:^(RKMappingResult *result) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteMessage duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.messagesDataProvider deleteItem:message];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

@end
