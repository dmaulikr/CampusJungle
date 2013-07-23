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
#import "CCUserSessionProtocol.h"
#import "CCEditGroupViewController.h"

@interface CCGroupViewController () <CCGroupTableDelegate, CCEditGroupDelegate>

@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *subjectLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *ownerLabel;
@property (nonatomic, weak) IBOutlet UIButton *editButton;

@property (nonatomic, strong) CCGroupTableController *groupTableController;
@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;

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
    [self.nameLabel setText:self.group.name];
    [self.ownerLabel setText:[NSString stringWithFormat:@"Owner: %@ %@", self.group.ownerFirstName, self.group.ownerLastName]];
    [self.subjectLabel setText:self.group.description];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CCAPIDefines.baseURL, self.group.image]] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    [self setTitle:self.group.name];
}

- (void)setupButtons
{
    [self setupLeaveButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.editButton];
    if (![self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.group.ownerId]) {
        [self.editButton setHidden:YES];
    }
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
    if ([self.group.ownerId isEqualToString:self.ioc_userSessionProvider.currentUser.uid]) {
        [CCAlertHelper showWithMessage:CCAlertsMessages.leaveGroupByOwner success:^{
            [weakSelf.ioc_groupsApiProvider destroyGroup:weakSelf.group successHandler:^(RKMappingResult *result) {
                [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.leaveGroup duration:CCProgressHudsConstants.loaderDuration];
                [weakSelf.backTransaction perform];
            } errorHandler:^(NSError *error) {
                [CCStandardErrorHandler showErrorWithError:error];
            }];
        }];
    }
    else {
        [CCAlertHelper showWithMessage:CCAlertsMessages.leaveGroup success:^{
            [weakSelf.ioc_groupsApiProvider leaveGroup:weakSelf.group successHandler:^(RKMappingResult *result) {
                [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.leaveGroup duration:CCProgressHudsConstants.loaderDuration];
                [weakSelf.backTransaction perform];
            } errorHandler:^(NSError *error) {
                [CCStandardErrorHandler showErrorWithError:error];
            }];
        }];
    }
}

- (IBAction)editButtonDidPressed:(id)sender
{
    NSDictionary *params = @{@"group" : self.group, @"delegate" : self};
    [self.editGroupTransaction performWithObject:params];
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

- (void)showDetailsOfGroupMessage:(CCMessage *)message
{
    [self.messageDetailsTransaction performWithObject:message];
}

- (void)addLocation
{
    [self.addLocationTransaction performWithObject:self.group];
}

- (void)addForum
{
    [self.addForumTransaction performWithObject:self.group];
}

- (void)sendGroupMessage
{
    [self.groupMessageTransaction performWithObject:self.group];
}

#pragma mark -
#pragma mark CCEditGroupDelegate
- (void)updateWithGroup:(CCGroup *)group
{
    self.group.name = group.name;
    self.group.description = group.description;
    self.group.image = group.image;
    [self loadInfo];
}

@end
