//
//  CCMenuControllerViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuController.h"
#import "CCSideMenuDataSource.h"
#import "CCOrdinaryCell.h"
#import "CCMenuDefines.h"
#import "CCUserSessionProtocol.h"
#import "CCClassesApiProviderProtocol.h"

@interface CCSideMenuController () <CCCellSelectionProtocol, CCSideMenuDelegate>

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UIButton *userProfileButton;

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userProfile;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPI;
@property (nonatomic, strong) CCSideMenuDataSource *dataSource;

@end

@implementation CCSideMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupButtons];
    [self setupLabels];
    [self addObservers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserClasses];
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserClasses) name:CCNotificationsNames.reloadSideMenu object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCNotificationsNames.reloadSideMenu object:nil];
}

- (void)setupTableViewWithEducationsArray:(NSArray *)educationsArray
{
    self.dataSource = [[CCSideMenuDataSource alloc] initWithDelegate:self sectionsArray:educationsArray];
    [self.mainTable setDataSource:self.dataSource];
    [self.mainTable setDelegate:self.dataSource];
    [self.mainTable reloadData];
}

- (void)setupLabels
{
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",[[self.ioc_userProfile currentUser] firstName], [[self.ioc_userProfile currentUser] lastName]];
}

- (void)setupButtons
{
    [self.userProfileButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.userProfileButton setBackgroundImage:nil forState:UIControlStateHighlighted];
}

- (void)loadUserClasses
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak CCSideMenuController *weakSelf = self;
    [self.ioc_classesAPI getClassesInCollegesWithSuccessHandler:^(NSArray *educationsArray) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf setupTableViewWithEducationsArray:educationsArray];
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [CCStandardErrorHandler showErrorWithError:error];
    } ];
}

#pragma mark -
#pragma mark Actions
- (IBAction)userProfileButtonDidPressed:(id)sender
{
    [self.userProfileTransaction perform];
}

#pragma mark -
#pragma mark CCSideMenuDelegate
- (void)showNewsFeed
{
    [self.inboxTransaction perform];
}

- (void)showMarketPlace
{
    [self.marketTransaction perform];
}

- (void)showDetailsOfClass:(CCClass *)classObject
{
    [self.classTransaction performWithObject:classObject];
}

- (void)addClassToCollegeWithId:(NSString *)collegeId
{
    [self.classesOfCollegeTransaction performWithObject:collegeId];
}

@end