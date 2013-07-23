//
//  CCEditGroupViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEditGroupViewController.h"
#import "CCGroup.h"
#import "CCStringHelper.h"
#import "CCButtonsHelper.h"
#import "CCGroupsApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCGroupmatesDataProvider.h"
#import "CCSelectableCellsDataSource.h"
#import "CCUserSelectionCell.h"
#import "CCAvatarSelectionActionSheet.h"
#import "CCKeyboardHelper.h"

@interface CCEditGroupViewController () <UITextFieldDelegate, CCAvatarSelectionProtocol>

@property (nonatomic, weak) IBOutlet UIView *tableHeaderView;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *subjectTextField;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIButton *selectLogoButton;

@property (nonatomic, weak) id<CCEditGroupDelegate> delegate;
@property (nonatomic, strong) CCGroup *group;
@property (nonatomic, strong) CCGroup *updatedGroup;
@property (nonatomic, strong) CCGroupmatesDataProvider *dataProvider;
@property (nonatomic, strong) CCSelectableCellsDataSource *dataSource;
@property (nonatomic, strong) CCAvatarSelectionActionSheet *logoSelectionSheet;
@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;

@end

@implementation CCEditGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTextFields];
    [self setupImageView];
    [self setupButtons];
    [self setupTableView];
    [self configLogoSelectionSheet];
    self.updatedGroup = [CCGroup new];
    
    [self setTitle:@"Edit Group"];
    [self setRightNavigationItemWithTitle:@"Save" selector:@selector(saveButtonDidPressed:)];
}

- (void)setupTextFields
{
    [self.nameTextField setText:self.group.name];
    [self.subjectTextField setText:self.group.description];
}

- (void)setupImageView
{
    [self.logoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", CCAPIDefines.baseURL, self.group.image]] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
}

- (void)setupButtons
{
    [CCButtonsHelper removeBackgroundImageInButton:self.selectLogoButton];
}

- (void)setupTableView
{
    self.mainTable.tableHeaderView = self.tableHeaderView;
    self.dataSource = [CCSelectableCellsDataSource new];
    self.dataProvider = [CCGroupmatesDataProvider new];
    [self.dataProvider setNeedToSelectAllItems:YES];
    [self.dataProvider setGroup:self.group];
    [self.dataProvider setItemsPerPage:INT_MAX];
    [self configTableWithProvider:self.dataProvider cellClass:[CCUserSelectionCell class]];
}

- (void)configLogoSelectionSheet
{
    self.logoSelectionSheet = [CCAvatarSelectionActionSheet new];
    self.logoSelectionSheet.delegate = self;
}

#pragma mark -
#pragma mark Actions
- (void)saveButtonDidPressed:(id)sender
{
    [CCKeyboardHelper hideKeyboard];
    if ([self validateInputData]) {
        self.updatedGroup.groupId = self.group.groupId;
        self.updatedGroup.name = self.nameTextField.text;
        self.updatedGroup.description = self.subjectTextField.text;
        self.updatedGroup.usersIds = [self selectedUsersIdsArray];
        [self updateGroup:self.updatedGroup];
    }
}

- (IBAction)selectLogoButtonDidPressed:(id)sender
{
    [CCKeyboardHelper hideKeyboard];
    [self.logoSelectionSheet showWithTitle:@"Select Group Logo" takePhotoButtonTitle:nil takeFromGalleryButtonTitle:nil];
}

- (NSArray *)selectedUsersIdsArray
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelected == YES"];
    NSArray *usersArray = [self.dataProvider.arrayOfItems filteredArrayUsingPredicate:predicate];
    return [usersArray valueForKeyPath:@"uid"];
}

#pragma mark -
#pragma mark Input Data Validation
- (BOOL)validateInputData
{
    if ([self.nameTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyName];
        return NO;
    }
    if ([self.subjectTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyDescription];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Requests
- (void)updateGroup:(CCGroup *)group
{
    __weak CCEditGroupViewController *weakSelf = self;
    [SVProgressHUD showWithStatus:CCProcessingMessages.updatingGroup];
    [self.ioc_groupsApiProvider updateGroup:group successHandler:^(RKMappingResult *result) {
        weakSelf.group = (CCGroup *)result;
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.updatedGroup duration:CCProgressHudsConstants.loaderDuration];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(updateWithGroup:)]) {
            [weakSelf.delegate updateWithGroup:weakSelf.group];
        }
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

#pragma mark -
#pragma mark CCAvatarSelectionProtocol
- (void)didSelectAvatar:(UIImage *)avatar
{
    self.updatedGroup.selectedLogo = avatar;
    [self.logoImageView setImage:avatar];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        [self.subjectTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [CCStringHelper trimSpacesFromString:textField.text];
}

@end
