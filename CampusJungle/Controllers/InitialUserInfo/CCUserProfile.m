//
//  CCInitialUserInfoController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserProfile.h"
#import "CCUserSessionProtocol.h"
#import "UIAlertView+Blocks.h"
#import "CCAlertDefines.h"
#import "CCUserCollegesTableDataSource.h"
#import "CCDefines.h"

@interface CCUserProfile ()

@property (nonatomic, weak) IBOutlet UILabel *firstName;
@property (nonatomic, weak) IBOutlet UILabel *lastName;
@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UIView *tableFooterView;
@property (nonatomic, weak) IBOutlet UIView *tableHeaderView;
@property (nonatomic, weak) IBOutlet UITableView *collegeTable;

@property (nonatomic, strong) CCUserCollegesTableDataSource *tableDataSource;

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCUserProfile

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collegeTable.tableFooterView = self.tableFooterView;
    self.collegeTable.tableHeaderView = self.tableHeaderView;
    self.firstName.text = [[self.ioc_userSession currentUser] firstName];
    self.lastName.text = [[self.ioc_userSession currentUser] lastName];
    self.email.text = [[self.ioc_userSession currentUser] email];
    NSString *avatarURL = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,[[self.ioc_userSession currentUser] avatar]];
    [self.avatar setImageWithURL:[NSURL URLWithString:avatarURL]];
    self.tableDataSource = [CCUserCollegesTableDataSource new];
    self.collegeTable.dataSource = self.tableDataSource;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(logout)];
}

- (void)logout
{
    RIButtonItem *yesItem = [RIButtonItem itemWithLabel:CCAlertsButtons.yesButton];
    yesItem.action = ^{
        [self.logoutTransaction perform];
    };
    
    RIButtonItem *noItem = [RIButtonItem itemWithLabel: CCAlertsButtons.noButton];
    
    UIAlertView *confirmAlert = [[UIAlertView alloc] initWithTitle:nil
                                                           message:CCAlertsMessages.confimAlert
                                                  cancelButtonItem:noItem
                                                  otherButtonItems:yesItem, nil];
    [confirmAlert show];    
}


@end
