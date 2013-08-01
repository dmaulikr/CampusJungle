//
//  CCInboxControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInboxController.h"
#import "CCOffer.h"
#import "CCMessage.h"
#import "CCGroupInvite.h"

#import "CCUserSessionProtocol.h"
#import "CCMessageAPIProviderProtocol.h"
#import "CCGroupInvitesApiProviderProtocol.h"
#import "CCAlertHelper.h"

#import "CCMessageCell.h"
#import "CCOfferCell.h"
#import "CCGroupInviteCell.h"
#import "CCOrdinaryCell.h"

#import "CCMessagesDataProvider.h"
#import "CCOffersDataProvider.h"
#import "CCGroupInvitesDataProvider.h"
#import "CCInboxAppInvitesDataProvider.h"

#define MessagesState 0
#define GroupInvitesState 1
#define AppInviteState 3
#define OffersState 2

@interface CCInboxController () <CCMessageCellDelegate, CCGroupInviteCellDelegate>

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id<CCMessageAPIProviderProtocol> ioc_messagesApiProvider;
@property (nonatomic, strong) id<CCGroupInvitesApiProviderProtocol> ioc_groupInvitesApiProvider;

@property (nonatomic, strong) CCMessagesDataProvider *messagesDataProvider;
@property (nonatomic, strong) CCOffersDataProvider *offersDataProvider;
@property (nonatomic, strong) CCGroupInvitesDataProvider *groupInvitesDataProvider;
@property (nonatomic, strong) CCInboxAppInvitesDataProvider *appInviteDataProvider;

@property (nonatomic) NSInteger currentState;

@property (nonatomic, weak) IBOutlet UISegmentedControl *mainSegmentedControl;

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
    if ([self.ioc_userSession currentUser]){
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
        case GroupInvitesState:{
            [self setGroupsInvitesConfiguration];
            break;
        }
        case OffersState:{
            [self setOfferConfiguration];
            break;
        }
        case AppInviteState:{
            [self setAppInvitesConfiguration];
            break;
        }
    }
}

- (void)selectTabAtIndex:(NSInteger)tabIndex
{
    [self.mainSegmentedControl setSelectedSegmentIndex:tabIndex];
    [self segmentedControlDidChangeValue:self.mainSegmentedControl];
}

- (void)setAppInvitesConfiguration
{
    if (!self.appInviteDataProvider) {
        self.appInviteDataProvider = [CCInboxAppInvitesDataProvider new];
    }
    [self configTableWithProvider:self.appInviteDataProvider cellClass:[CCOrdinaryCell class]];
}

- (void)setGroupsInvitesConfiguration
{
    if (!self.groupInvitesDataProvider) {
        self.groupInvitesDataProvider = [CCGroupInvitesDataProvider new];
    }
    [self configTableWithProvider:self.groupInvitesDataProvider cellClass:[CCGroupInviteCell class] cellReuseIdentifier:NSStringFromClass([CCGroupInviteCell class])];
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

#pragma mark -
#pragma mark CCGroupInviteCellDelegate
- (void)acceptGroupInvite:(CCGroupInvite *)groupInvite
{
    __weak CCInboxController *weakSelf = self;
    [self.ioc_groupInvitesApiProvider acceptGroupInviteWithId:groupInvite.groupInviteId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.acceptGroupInvite duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.groupInvitesDataProvider deleteItem:groupInvite];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)rejectGroupInvite:(CCGroupInvite *)groupInvite
{
    __weak CCInboxController *weakSelf = self;
    [self.ioc_groupInvitesApiProvider rejectGroupInviteWithId:groupInvite.groupInviteId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.rejectGroupInvite duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.groupInvitesDataProvider deleteItem:groupInvite];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];

}

- (void)resendGroupInvite:(CCGroupInvite *)groupInvite
{
    __weak CCInboxController *weakSelf = self;
    [self.ioc_groupInvitesApiProvider resendGroupInviteWithId:groupInvite.groupInviteId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.resendGroupInvite duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.groupInvitesDataProvider loadItems];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)deleteGroupInvite:(CCGroupInvite *)groupInvite
{
    __weak CCInboxController *weakSelf = self;
    [self.ioc_groupInvitesApiProvider deleteGroupInviteWithId:groupInvite.groupInviteId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteGroupInvite duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.groupInvitesDataProvider deleteItem:groupInvite];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
