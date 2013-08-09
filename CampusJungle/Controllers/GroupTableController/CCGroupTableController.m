//
//  CCGroupTableController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupTableController.h"
#import "CCClassControllerTableDataSource.h"
#import "CCLocationDataProviderDelegate.h"
#import "CCGroupTabbarViewController.h"
#import "CCViewPositioningHelper.h"
#import "CCAlertHelper.h"
#import "CCLocation.h"
#import "CCGroup.h"
#import "CCMessage.h"
#import "CCButtonsHelper.h"
#import "CCGroupTabbarDelegate.h"

#import "CCGroupmatesDataProvider.h"
#import "CCLocationsDataProvider.h"
#import "CCQuestionsDataProvider.h"
#import "CCMessagesDataProvider.h"

#import "CCUserCell.h"
#import "CCLocationCell.h"
#import "CCQuestionCell.h"
#import "CCMessageCell.h"

#import "CCStandardErrorHandler.h"
#import "CCLocationsApiProviderProtocol.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCMessageAPIProviderProtocol.h"

static const NSInteger kTabbarHeight = 52;
static const NSInteger kNavBarHeight = 44;

@interface CCGroupTableController () <CCGroupTabbarDelegate, CCLocationDataProviderDelegate, CCLocationCellDelegate, CCQuestionCellDelegate, CCMessageCellDelegate>

@property (nonatomic, weak) IBOutlet UIView *sectionHeaderView;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property (nonatomic, weak) IBOutlet UILabel *sectionName;

@property (nonatomic, strong) CCGroup *group;

@property (nonatomic, strong) CCGroupTabbarViewController *groupTabbarController;
@property (nonatomic, strong) CCGroupmatesDataProvider *groupmatesProvider;
@property (nonatomic, strong) CCLocationsDataProvider *locationsProvider;
@property (nonatomic, strong) CCQuestionsDataProvider *questionsProvider;
@property (nonatomic, strong) CCMessagesDataProvider *messagesProvider;
@property (nonatomic, strong) CCBaseDataProvider *activeDataProvider;

@property (nonatomic, strong) id<CCLocationsApiProviderProtocol> ioc_locationsApiProvider;
@property (nonatomic, strong) id<CCQuestionsApiProviderProtocol> ioc_questionsApiProvider;
@property (nonatomic, strong) id<CCMessageAPIProviderProtocol> ioc_messagesApiProvider;

@property (nonatomic, strong) NSMutableArray *locationsArray;
@property (nonatomic, assign) CGPoint tableViewContentOffsetBeforeReload;

@end

@implementation CCGroupTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addObservers];
    
    self.locationsArray = [NSMutableArray array];
    self.dataSourceClass = [CCClassControllerTableDataSource class];
    
    self.groupTabbarController = [CCGroupTabbarViewController new];
    self.groupTabbarController.delegate = self;
    
    [self.sectionHeaderView addSubview:self.groupTabbarController.view];
    [(CCClassControllerTableDataSource *)self.dataSource setViewForSectionHeader:self.sectionHeaderView];
    self.mainTable.tableHeaderView = self.tableHeaderView;
    [CCButtonsHelper removeBackgroundImageInButton:self.addButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.activeDataProvider) {
        [self.activeDataProvider loadItems];
    }
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLocations) name:CCNotificationsNames.reloadClassLocations object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.reloadClassLocations object:nil];
}

- (void)setGroupmatesConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.groupmates;
    self.searchBar.placeholder = CCSearchBarPlaceholders.searchGroupmates;
    if (!self.groupmatesProvider) {
        self.groupmatesProvider = [CCGroupmatesDataProvider new];
        self.groupmatesProvider.group = self.group;
        self.groupmatesProvider.cellReuseIdentifier = CCTableDefines.classmatesCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.groupmatesProvider];
    [self configTableWithProvider:self.groupmatesProvider cellClass:[CCUserCell class] cellReuseIdentifier:CCTableDefines.classmatesCellIdentifier];
    self.activeDataProvider = self.groupmatesProvider;
}

- (void)setQuestionsConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.questions;
    self.searchBar.placeholder = CCSearchBarPlaceholders.searchQuestions;
    if (!self.questionsProvider) {
        self.questionsProvider = [CCQuestionsDataProvider new];
        self.questionsProvider.groupId = self.group.groupId;
        self.questionsProvider.cellReuseIdentifier = CCTableDefines.questionsCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.questionsProvider];
    [self configTableWithProvider:self.questionsProvider cellClass:[CCQuestionCell class] cellReuseIdentifier:CCTableDefines.questionsCellIdentifier];
    self.activeDataProvider = self.questionsProvider;
}

- (void)setLocationConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.locations;
    self.searchBar.placeholder = CCSearchBarPlaceholders.searchLocations;
    if (!self.locationsProvider) {
        self.locationsProvider = [[CCLocationsDataProvider alloc] initWithDelegate:self];
        self.locationsProvider.groupId = self.group.groupId;
        self.locationsProvider.cellReuseIdentifier = CCTableDefines.locationsCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.locationsProvider];
    [self configTableWithProvider:self.locationsProvider cellClass:[CCLocationCell class] cellReuseIdentifier:CCTableDefines.locationsCellIdentifier];
    self.activeDataProvider = self.locationsProvider;
}

- (void)setGroupMessagesConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.groupMessages;
    self.searchBar.placeholder = CCSearchBarPlaceholders.searchMessages;
    if (!self.messagesProvider) {
        self.messagesProvider = [CCMessagesDataProvider new];
        self.messagesProvider.filters = @{@"group_id" : self.group.groupId, @"direction" : @"all"};
        self.messagesProvider.cellReuseIdentifier = CCTableDefines.messageCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.messagesProvider];
    [self configTableWithProvider:self.messagesProvider cellClass:[CCMessageCell class] cellReuseIdentifier:CCTableDefines.messageCellIdentifier];
    self.activeDataProvider = self.messagesProvider;
}

#pragma mark -
#pragma mark Overriding base methods
- (void)tableViewWillReloadData
{
    self.tableViewContentOffsetBeforeReload = CGPointMake(0, MIN(self.mainTable.contentOffset.y, 200));
    [super tableViewWillReloadData];
}

- (void)tableViewDidReloadData
{
    CGPoint newContentOffset = self.mainTable.contentOffset;
    [self.mainTable setContentOffset:self.tableViewContentOffsetBeforeReload];
    [self.mainTable setContentOffset:newContentOffset animated:YES];
    [super tableViewDidReloadData];
}

#pragma mark -
#pragma mark Actions
- (void)fillSearchBarFromDataProvider:(CCBaseDataProvider *)dataProvider
{
    [self.searchBar setText:dataProvider.searchQuery];
}

- (void)reloadLocations
{
    [self.locationsProvider loadItems];
}

- (void)didSelectBarItemWithIdentifier:(NSInteger)identifier
{
    switch (identifier) {
        case CCClassTabbarButtonsIdentifierClassmate:
            [self setGroupmatesConfiguration];
            break;
        case CCClassTabbarButtonsIdentifierLocations:
            [self setLocationConfiguration];
            break;
        case CCClassTabbarButtonsIdentifierQuestions:
            [self setQuestionsConfiguration];
            break;
        case CCClassTabbarButtonsIdentifierGroup:
            [self setGroupMessagesConfiguration];
            break;
    }
}

- (void)didReselectBarItemWithIdentifier:(NSInteger)identifier
{
    [self.mainTable setContentOffset:CGPointZero animated:YES];
}

- (void)setTableHeaderView:(UIView *)tableHeaderView
{
    _tableHeaderView = tableHeaderView;
    self.mainTable.tableHeaderView = tableHeaderView;
}

#pragma mark -
#pragma mark CCLocationDataProviderDelegate
- (void)didLoadLocations:(NSArray *)locationsArray
{
    [self.locationsArray addObjectsFromArray:locationsArray];
}

#pragma mark -
#pragma mark CCLocationCellDelegate
- (void)deleteLocation:(CCLocation *)location
{
    __weak CCGroupTableController *weakSelf = self;
    [CCAlertHelper showConfirmWithSuccess:^{
        [weakSelf.ioc_locationsApiProvider deleteLocation:location successHandler:^(RKMappingResult *object) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteLocation duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.locationsProvider deleteItem:location];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

#pragma mark -
#pragma mark CCQuestionCellDelegate
- (void)deleteQuestion:(CCQuestion *)question
{
    __weak CCGroupTableController *weakSelf = self;
    [CCAlertHelper showConfirmWithSuccess:^{
        [self.ioc_questionsApiProvider deleteQuestion:question successHandler:^(RKMappingResult *object) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteQuestion duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.questionsProvider deleteItem:question];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

- (void)emailAttachmentOfQuestion:(CCQuestion *)question
{
    [self.ioc_questionsApiProvider emailAttachmentOfQuestion:question successHandler:^(id object) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.questionAttachmentEmailed duration:CCProgressHudsConstants.loaderDuration];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)viewAttachmentOfQuestion:(CCQuestion *)question
{
    [self.delegate viewAttachmentOfQuestion:question];
}

#pragma mark -
#pragma mark CCMessageCellDelegate
- (void)deleteMessage:(CCMessage *)message
{
    __weak CCGroupTableController *weakSelf = self;
    [CCAlertHelper showWithMessage:CCAlertsMessages.deleteMessage success:^{
        [weakSelf.ioc_messagesApiProvider deleteMessageWithId:message.messageID successHandler:^(RKMappingResult *result) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteMessage duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.messagesProvider deleteItem:message];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

#pragma mark -
#pragma mark TableView callbacks
- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    NSInteger identifier = [self.groupTabbarController selectedButtonIdentifier];
    switch (identifier) {
        case CCClassTabbarButtonsIdentifierClassmate:
            [self.delegate showProfileOfUser:cellObject];
            break;
        case CCClassTabbarButtonsIdentifierLocations:
            [self.delegate showLocation:cellObject onMapWithLocations:self.locationsArray];
            break;
        case CCClassTabbarButtonsIdentifierQuestions:
            [self.delegate showDetailsOfQuestion:cellObject];
            break;
        case CCClassTabbarButtonsIdentifierGroup:
            [self.delegate showDetailsOfGroupMessage:cellObject];
            break;
    }
}

- (IBAction)addButtonDidPressed:(id)sender
{
    NSInteger identifier = [self.groupTabbarController selectedButtonIdentifier];
    switch (identifier) {
        case CCClassTabbarButtonsIdentifierClassmate:
            [self.delegate addGroupmates];
            break;
        case CCClassTabbarButtonsIdentifierLocations:
            [self.delegate addLocation];
            break;
        case CCClassTabbarButtonsIdentifierQuestions:
            [self.delegate addQuestion];
            break;
        case CCClassTabbarButtonsIdentifierGroup:
            [self.delegate sendGroupMessage];
            break;
    }
}

@end