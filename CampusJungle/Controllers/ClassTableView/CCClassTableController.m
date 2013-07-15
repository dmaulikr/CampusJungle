//
//  CCClassTableController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassTableController.h"
#import "CCClassControllerTableDataSource.h"
#import "CCLocationDataProviderDelegate.h"
#import "CCClassTabbarControllerViewController.h"
#import "CCViewPositioningHelper.h"
#import "CCAlertHelper.h"
#import "CCLocation.h"

#import "CCClassmatesDataProvider.h"
#import "CCClassLocationsDataProvider.h"
#import "CCGroupsDataProvider.h"
#import "CCForumsDataProvider.h"

#import "CCUserCell.h"
#import "CCLocationCell.h"
#import "CCGroupCell.h"

#import "CCStandardErrorHandler.h"
#import "CCLocationsApiProviderProtocol.h"

static const NSInteger kTabbarHeight = 52;
static const NSInteger kNavBarHeight = 44;

@interface CCClassTableController () <CCClassTabbarControllerDelegateProtocol, CCLocationDataProviderDelegate, CCLocationCellDelegate>

@property (nonatomic, weak) IBOutlet UIView *sectionHeaderView;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property (nonatomic, weak) IBOutlet UILabel *sectionName;

@property (nonatomic, strong) CCClassTabbarControllerViewController *classTabbarController;

@property (nonatomic, strong) CCClassmatesDataProvider *classmatesProvider;
@property (nonatomic, strong) CCClassLocationsDataProvider *locationsProvider;
@property (nonatomic, strong) CCForumsDataProvider *forumsProvider;
@property (nonatomic, strong) CCGroupsDataProvider *groupsProvider;
@property (nonatomic, strong) CCBaseDataProvider *activeDataProvider;

@property (nonatomic, strong) id<CCLocationsApiProviderProtocol> ioc_locationsApiProvider;

@property (nonatomic, strong) NSMutableArray *locationsArray;
@property (nonatomic, assign) CGPoint tableViewContentOffsetBeforeReload;

@end

@implementation CCClassTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addObservers];
    
    self.locationsArray = [NSMutableArray array];
    
    self.dataSourceClass = [CCClassControllerTableDataSource class];
    
    CCClassTabbarControllerViewController *tabbarController = [CCClassTabbarControllerViewController new];
    tabbarController.delegate = self;
    self.classTabbarController = tabbarController;
    
    [self.sectionHeaderView addSubview:tabbarController.view];
    [(CCClassControllerTableDataSource *)self.dataSource setViewForSectionHeader:self.sectionHeaderView];
    self.mainTable.tableHeaderView = self.tableHeaderView;
    [self.addButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.addButton setBackgroundImage:nil forState:UIControlStateHighlighted];
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

- (void)setClassmatesConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.classmates;
    if (!self.classmatesProvider) {
        self.classmatesProvider = [CCClassmatesDataProvider new];
        self.classmatesProvider.classID = self.classID;
        self.classmatesProvider.cellReuseIdentifier = CCTableDefines.classmatesCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.classmatesProvider];
    [self configTableWithProvider:self.classmatesProvider cellClass:[CCUserCell class] cellReuseIdentifier:CCTableDefines.classmatesCellIdentifier];
    self.activeDataProvider = self.classmatesProvider;
}

- (void)setForumsConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.forums;
    if (!self.forumsProvider) {
        self.forumsProvider = [CCForumsDataProvider new];
        self.forumsProvider.cellReuseIdentifier = CCTableDefines.forumsCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.forumsProvider];
    [self configTableWithProvider:self.forumsProvider cellClass:[UITableViewCell class] cellReuseIdentifier:CCTableDefines.forumsCellIdentifier];
    self.activeDataProvider = self.forumsProvider;
}

- (void)setLocationConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.locations;
    if (!self.locationsProvider) {
        self.locationsProvider = [[CCClassLocationsDataProvider alloc] initWithDelegate:self];
        self.locationsProvider.classId = self.classID;
        self.locationsProvider.cellReuseIdentifier = CCTableDefines.locationsCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.locationsProvider];
    [self configTableWithProvider:self.locationsProvider cellClass:[CCLocationCell class] cellReuseIdentifier:CCTableDefines.locationsCellIdentifier];
    self.activeDataProvider = self.locationsProvider;
}

- (void)setGroupsConfiguration
{
    self.sectionName.text = CCClassTabbarButtonsTitles.groups;
    if (!self.groupsProvider) {
        self.groupsProvider = [CCGroupsDataProvider new];
        self.groupsProvider.classId = self.classID;
        self.groupsProvider.cellReuseIdentifier = CCTableDefines.groupsCellIdentifier;
    }
    [self fillSearchBarFromDataProvider:self.groupsProvider];
    [self configTableWithProvider:self.groupsProvider cellClass:[CCGroupCell class] cellReuseIdentifier:CCTableDefines.groupsCellIdentifier];
    self.activeDataProvider = self.groupsProvider;
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
            [self setClassmatesConfiguration];
            break;
        case CCClassTabbarButtonsIdentifierGroup:
            [self setGroupsConfiguration];
            break;
        case CCClassTabbarButtonsIdentifierLocations:
            [self setLocationConfiguration];
            break;
        case CCClassTabbarButtonsIdentifierForums:
            [self setForumsConfiguration];
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
    __weak CCClassTableController *weakSelf = self;
    [CCAlertHelper showConfirmWithSuccess:^{
        [weakSelf.ioc_locationsApiProvider deleteLocation:location successHandler:^(RKMappingResult *object) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.deleteLocation duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.locationsProvider loadItems];
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
    NSInteger identifier = [self.classTabbarController selectedButtonIdentifier];
    switch (identifier) {
        case CCClassTabbarButtonsIdentifierClassmate:
            [self.delegate showProfileOfUser:cellObject];
            break;
        case CCClassTabbarButtonsIdentifierGroup:
            // go group details
            break;
        case CCClassTabbarButtonsIdentifierLocations:
            [self.delegate showLocation:cellObject onMapWithLocations:self.locationsArray];
            break;
        case CCClassTabbarButtonsIdentifierForums:
            // go forum details
            break;
    }
}

- (IBAction)addButtonDidPressed:(id)sender
{
    NSInteger identifier = [self.classTabbarController selectedButtonIdentifier];
    switch (identifier) {
        case CCClassTabbarButtonsIdentifierClassmate:
            // go add classmate

            break;
        case CCClassTabbarButtonsIdentifierGroup:
            // go add group
            break;
        case CCClassTabbarButtonsIdentifierLocations:
            [self.delegate addLocationToClassWithId:self.classID];
            break;
        case CCClassTabbarButtonsIdentifierForums:
            // go add forum
            break;
    }
}

@end