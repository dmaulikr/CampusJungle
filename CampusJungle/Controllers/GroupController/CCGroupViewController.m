//
//  CCGroupViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupViewController.h"
#import "CCGroup.h"
#import "CCButtonsHelper.h"
#import "CCAlertHelper.h"
#import "CCStandardErrorHandler.h"

#import "CCGroupTableController.h"
#import "CCGroupsApiProviderProtocol.h"

@interface CCGroupViewController () <CCGroupTableDelegate>

@property (nonatomic, weak) IBOutlet UIView *headerView;

@property (nonatomic, strong) CCGroupTableController *groupTableController;
@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;

@property (nonatomic, strong) CCGroup *group;

@end

@implementation CCGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadInfo];
    [self setupButtons];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.groupTableController viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.groupTableController viewWillDisappear:animated];
}


- (void)loadInfo
{
    
}

- (void)setupButtons
{
    [self setupLeaveButton];
}

- (void)setupLeaveButton
{
    UIImage *leaveClassImage = [UIImage imageNamed:@"leave_class_icon"];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, leaveClassImage.size.width  - 10, leaveClassImage.size.height - 10)];
    [button setImage:leaveClassImage forState:UIControlStateNormal];
    [CCButtonsHelper removeBackgroundImageInButton:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    [button addTarget:self action:@selector(leaveGroupButtonDidPressed:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setupTableView
{
    self.groupTableController = [CCGroupTableController new];
    self.groupTableController.tableHeaderView = self.headerView;
    [self.groupTableController setGroup:self.group];
    self.groupTableController.delegate = self;
    [self.view addSubview:self.groupTableController.view];
}

#pragma mark -
#pragma mark Actions
- (void)leaveGroupButtonDidPressed:(id)sender
{
    __weak CCGroupViewController *weakSelf = self;
    [CCAlertHelper showWithMessage:@"Are you sure that you want to leave group?" success:^{
        [weakSelf.ioc_groupsApiProvider leaveGroup:weakSelf.group successHandler:^(RKMappingResult *result) {
            [SVProgressHUD showSuccessWithStatus:@"You've successfully leave group" duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.backTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

#pragma mark -
#pragma mark CCGroupTableDelegate
- (void)showProfileOfUser:(CCUser *)user
{
    [self.otherUserProfileTransaction performWithObject:user];
}

- (void)showLocation:(CCLocation *)location onMapWithLocations:(NSArray *)locationsArray
{
    NSString *searchString = ([self.groupTableController.searchBar.text length] > 0) ? self.groupTableController.searchBar.text : @"";
    [self.locationTransaction performWithObject:@{@"location" : location, @"array" : locationsArray, @"group" : self.group, @"searchString" : searchString}];
}

- (void)showDetailsOfForum:(CCForum *)forum
{
    [self.forumDetailsTransaction performWithObject:forum];
}

- (void)addLocation
{
    [self.addLocationTransaction performWithObject:self.group];
}

- (void)addForum
{
    [self.addForumTransaction performWithObject:self.group];
}

@end
