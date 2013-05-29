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

#define animationDuration 0.4

@interface CCUserProfile ()

@property (nonatomic, weak) IBOutlet UILabel *firstName;
@property (nonatomic, weak) IBOutlet UILabel *lastName;
@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UIView *tableFooterView;
@property (nonatomic, weak) IBOutlet UIView *tableHeaderView;
@property (nonatomic, weak) IBOutlet UITableView *collegeTable;

@property (nonatomic, weak) IBOutlet UIButton *addCollegeButton;

@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;

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
    
    //[self setRightNavigationItemWithTitle:@"Logout" selector:@selector(logout)];
    [self setRightNavigationItemWithTitle:@"Edit" selector:@selector(edit)];
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

- (void)edit
{
    [self setEditing:YES animated:YES];
    [self setRightNavigationItemWithTitle:@"Save" selector:@selector(save)];
}

- (void)save
{
    [self setEditing:NO animated:YES];
    [self setRightNavigationItemWithTitle:@"Edit" selector:@selector(edit)];

}

- (void)setRightNavigationItemWithTitle:(NSString*)title selector:(SEL)selector
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:selector];

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    float duration = 0;
    if(animated){
        duration = animationDuration;
    }
    [UIView animateWithDuration:duration animations:^{
        if(editing){
            [self becomeEditable];
        } else {
            [self becomeNotEditable];
        }
    }];
}

- (void)becomeEditable
{
    self.firstNameField.text = self.firstName.text;
    self.lastNameField.text = self.lastName.text;
    self.emailField.text = self.email.text;
    
    self.firstName.alpha = 0;
    self.lastName.alpha = 0;
    self.email.alpha = 0;
    
    self.firstNameField.alpha = 1;
    self.lastNameField.alpha = 1;
    self.emailField.alpha = 1;
    
    self.addCollegeButton.alpha = 1;
}

- (void)becomeNotEditable
{
    [self.view endEditing:YES];
    
    self.firstName.alpha = 1;
    self.lastName.alpha = 1;
    self.email.alpha = 1;
    
    self.firstNameField.alpha = 0;
    self.lastNameField.alpha = 0;
    self.emailField.alpha = 0;
    
    self.addCollegeButton.alpha = 0;
}

- (IBAction)addCollegeButtonDidPressed
{
    [self.addColegeTransaction perform];
}

@end
