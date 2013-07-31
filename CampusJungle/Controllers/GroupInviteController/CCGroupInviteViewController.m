//
//  CCGroupInviteViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupInviteViewController.h"

#import "CCStringHelper.h"
#import "CCGroup.h"
#import "CCClassmatesToInviteInGroupDataProvider.h"
#import "CCSelectableCellsDataSource.h"
#import "CCUserSelectionCell.h"
#import "CCStandardErrorHandler.h"
#import "CCGroupInvitesApiProviderProtocol.h"

@interface CCGroupInviteViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *textBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextView *inviteTextView;

@property (nonatomic, strong) CCClassmatesToInviteInGroupDataProvider *dataProvider;
@property (nonatomic, strong) id<CCGroupInvitesApiProviderProtocol> ioc_groupInvitesApiProvider;
@property (nonatomic, strong) CCGroup *group;
@property (nonatomic, assign) BOOL textViewWillBecomeFirstResponder;

@end

@implementation CCGroupInviteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupImageView];
    [self setupTableView];
    
    [self setTitle:@"Group Invite"];
    [self setRightNavigationItemWithTitle:@"Send" selector:@selector(sendInviteButtonDidPressed:)];
}

- (void)setupImageView
{
    [self.textBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

- (void)setupTableView
{
    self.dataSourceClass = [CCSelectableCellsDataSource class];
    self.dataProvider = [CCClassmatesToInviteInGroupDataProvider new];
    [self.dataProvider setGroup:self.group];
    [self configTableWithProvider:self.dataProvider cellClass:[CCUserSelectionCell class]];
}

#pragma mark -
#pragma mark Actions
- (void)sendInviteButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        NSArray *selectedUsersIds = [self selectedUsersIds];
        [self sendInvitesToUsers:selectedUsersIds withMessage:self.inviteTextView.text];
    }
}

- (NSArray *)selectedUsersIds
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelected == YES"];
    NSArray *usersArray = [self.dataProvider.arrayOfItems filteredArrayUsingPredicate:predicate];
    return [usersArray valueForKeyPath:@"uid"];
}

#pragma mark -
#pragma mark Input Data Validation
- (BOOL)validateInputData
{
    if ([self.inviteTextView.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyMessageText];
        return NO;
    }
    if ([[self selectedUsersIds] count] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.noUsersSelected];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Requests
- (void)sendInvitesToUsers:(NSArray *)usersIds withMessage:(NSString *)message
{
    __weak CCGroupInviteViewController *weakSelf = self;
    [self.ioc_groupInvitesApiProvider sendInvitesInGroup:self.group.groupId withText:message toUsersWithIds:usersIds successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.groupInvitesSent duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [CCStringHelper trimSpacesFromString:textView.text];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.textViewWillBecomeFirstResponder = YES;
    __weak CCGroupInviteViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1.0);
        weakSelf.textViewWillBecomeFirstResponder = NO;
    });
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return !self.textViewWillBecomeFirstResponder;
}

@end
