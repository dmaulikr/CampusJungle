//
//  CCInitialUserInfoController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 23.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserProfile.h"
#import "CCUserSessionProtocol.h"
#import "CCEducationCell.h"
#import "CCEducationsDataProvider.h"
#import "CCLoginAPIProvider.h"
#import "CCStandardErrorHandler.h"
#import "MBProgressHUD.h"
#import "NSString+CJStringValidator.h"
#import "CCEducation.h"
#import "CCUserEducationsDataSource.h"
#import "CCAvatarSelectionActionSheet.h"
#import "CCAvatarSelectionProtocol.h"
#import "GIAlert.h"
#import "NSString+CCValidationHelper.h"
#import "DYRateView.h"
#import "CCUIImageHelper.h"
#import "CCPushNotificationsService.h"

#define animationDuration 0.4

@interface CCUserProfile () <CCAvatarSelectionProtocol>

@property (nonatomic, weak) IBOutlet UILabel *firstNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *lastNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UIView *tableFooterView;
@property (nonatomic, weak) IBOutlet UIView *tableHeaderView;
@property (nonatomic, weak) IBOutlet UIButton *avatarButton;

@property (nonatomic, weak) IBOutlet UIButton *addCollegeButton;

@property (nonatomic, weak) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;

@property (nonatomic, weak) IBOutlet UIButton *facebookButton;

@property (nonatomic, weak) IBOutlet UIButton *logoutButton;
@property (nonatomic, weak) IBOutlet UIButton *changePassButton;
@property (nonatomic, weak) IBOutlet UIButton *myNotesButton;
@property (nonatomic, weak) IBOutlet UIButton *mystuffButton;
@property (nonatomic, weak) IBOutlet UIButton *settingsButton;

@property (nonatomic, weak) IBOutlet UIView *rateContainer;
@property (nonatomic, strong) DYRateView *rateView;

@property (nonatomic, strong) CCEducationsDataProvider *dataProvider;

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

@property (nonatomic) BOOL isEditable;
@property (nonatomic) BOOL isNeedToUploadAvatar;

@property (nonatomic, strong) NSString *facebookAvatarPath;
@property (nonatomic, strong) NSMutableArray *arrayOfEducationsBackup;

@property (nonatomic, strong) CCAvatarSelectionActionSheet *avatarSelectionSheet;
@property (nonatomic, strong) UIBarButtonItem *sideMenuBarButton;
@property (nonatomic, strong) IBOutlet UILabel *walletLabel;

- (IBAction)manageWalletButtonDidPressed;
- (IBAction)settingsButtonDidPressed;

@end

@implementation CCUserProfile

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configStars];
    [self loadUser];
    [self setupTableView];
    [self setupButtons];
    [self setupImageViews];
    [self setupActionSheets];
    [self setupNavigationBar];
    [self addObservers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mainTable reloadData];
    float dollars = [[[self.ioc_userSession currentUser] wallet] floatValue]/100;
    self.walletLabel.text = [NSString stringWithFormat:@"$%0.2lf",dollars];
}

- (void)configStars
{
    self.rateView = [[DYRateView alloc] initWithFrame:self.rateContainer.bounds fullStar:[CCUIImageHelper scaleImageWithName:@"star_icon_active" withScale:2.0] emptyStar:[CCUIImageHelper scaleImageWithName:@"star_icon" withScale:2.0]];
    [self.rateContainer addSubview:self.rateView];
    self.rateView.alignment = RateViewAlignmentCenter;
}

- (void)delloc
{
    [self removeObservers];
}

- (void)loadUser
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_apiProvider loadUserInfoSuccessHandler:^(id result) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self saveUser:result];
        [self setupUserInfo];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)setupButtons
{
    if ([[[self.ioc_userSession currentUser] isFacebookLinked] isEqualToString:@"true"]){
        [self.facebookButton setHidden:YES];
    }
    self.facebookButton.alpha = 0;
    
    [self setButtonsTextColorInView:self.tableFooterView];
    [self setButtonsTextColorInView:self.tableHeaderView];
    [CCButtonsHelper removeBackgroundImageInButton:self.avatarButton];
}

- (void)setupImageViews
{
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setupActionSheets
{
    self.avatarSelectionSheet = [CCAvatarSelectionActionSheet new];
    self.avatarSelectionSheet.delegate = self;
}

- (void)setupUserInfo
{
    self.firstNameLabel.text = [[self.ioc_userSession currentUser] firstName];
    self.lastNameLabel.text = [[self.ioc_userSession currentUser] lastName];
    self.emailLabel.text = [[self.ioc_userSession currentUser] email];
    
    if (![self isEducations:self.arrayOfEducations equalTo:self.ioc_userSession.currentUser.educations]) {
        [self.arrayOfEducations removeAllObjects];
        [self.arrayOfEducations addObjectsFromArray:self.ioc_userSession.currentUser.educations];
        [self.dataProvider loadItems];
    }
    
    if ([[[self.ioc_userSession currentUser] avatar] length] > 0) {
        NSString *avatarURL = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,[[self.ioc_userSession currentUser] avatar]];
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:avatarURL]];
    }
    self.rateView.rate = [[[self.ioc_userSession currentUser] rank] floatValue];
    float dollars = [[[self.ioc_userSession currentUser] wallet] floatValue]/100;
    self.walletLabel.text = [NSString stringWithFormat:@"$%0.2lf",dollars];
}

- (void)setupNavigationBar
{
    self.title = @"My Profile";
    [self setRightNavigationItemWithTitle:@"Edit" selector:@selector(editProfile)];
    self.sideMenuBarButton = self.navigationItem.leftBarButtonItem;
}

- (IBAction)settingsButtonDidPressed
{
    [self.settingsTransaction perform];
}

- (void)setupTableView
{
    self.mainTable.tableFooterView = self.tableFooterView;
    self.mainTable.tableHeaderView = self.tableHeaderView;
    self.dataSourceClass = [CCUserEducationsDataSource class];
    self.dataProvider = [CCEducationsDataProvider new];
    self.dataProvider.arrayOfEducations = self.arrayOfEducations;
    [self configTableWithProvider:self.dataProvider cellClass:[CCEducationCell class]];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterForeground) name:CCAppDelegateDefines.notificationOnBackToForeground object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCAppDelegateDefines.notificationOnBackToForeground object:nil];
}

#pragma mark
#pragma mark Actions
- (void)applicationDidEnterForeground
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (IBAction)logout
{
    __weak CCUserProfile *weakSelf = self;
    GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.noButton action:nil];
    GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.yesButton action:^{
        [SVProgressHUD showWithStatus:CCProcessingMessages.logout];
        [CCPushNotificationsService unlinkDeviceTokenWithSuccessBlock:^{
            [SVProgressHUD dismiss];
            [weakSelf.logoutTransaction perform];
        } errorBlock:^(NSError *error) {
            [SVProgressHUD dismiss];
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
    
    GIAlert *alert = [GIAlert alertWithTitle:CCAlertsMessages.confirmation
                                     message:CCAlertsMessages.confimAlert
                                     buttons:@[noButton, yesButton,]];
    [alert show];
}

- (IBAction)manageWalletButtonDidPressed
{
    [self.walletTransaction perform];
}

- (void)editProfile
{
    [self setEditing:YES animated:YES];
}

- (void)saveProfile
{
    if ([self isFieldsValid]){
        if ([self isSomeEducationRemoved]) {
            GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.noButton action:nil];
            GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.yesButton action:^{
                [self performSaveOperation];
            }];
            
            GIAlert *alert = [GIAlert alertWithTitle:nil
                                             message:CCAlertsMessages.educationRemoving
                                             buttons:@[noButton, yesButton,]];
            [alert show];

        } else {
            [self performSaveOperation];
        }
    }
}

- (void)performSaveOperation
{
    [self sendUpdatedUserWithSuccess:^{
        [self setEditing:NO animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadSideMenu object:nil];
    }];
}

- (BOOL)isSomeEducationRemoved
{
    for (CCEducation *education in self.arrayOfEducationsBackup){
        if(![self.arrayOfEducations containsObject:education]){
            return YES;
        }
    }
    return NO;
}

- (void)saveUser:(CCUser *)user
{
    self.ioc_userSession.currentUser = user;
}

- (IBAction)addCollegeButtonDidPressed
{
    [self.addColegeTransaction perform];
}

- (void)exitEditProfileButtonDidPressed:(id)sender
{
    [self setEditing:NO animated:YES];
    [self.arrayOfEducations removeAllObjects];
    [self.arrayOfEducations addObjectsFromArray:self.arrayOfEducationsBackup];
    [self setupTableView];
    [self.mainTable reloadData];
}

- (IBAction)avatarDidPressed
{
    if (self.isEditable){
        [self.avatarSelectionSheet showWithTitle:@"Select Photo" takePhotoButtonTitle:nil takeFromGalleryButtonTitle:nil];
    }
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.isNeedToUploadAvatar = YES;
    self.avatarImageView.image = avatar;
}

- (IBAction)myNotesButtonDidPressed
{
    [self.myNotesTransaction perform];
}

- (IBAction)myStuffButtonDidPreessed
{
    [self.myStuffTransaction perform];
}

#pragma mark -
#pragma mark Validation Methods
- (BOOL)isFieldsValid
{
    if (![self.firstNameTextField.text isMinLength:1]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.firstNameNotValid];
        return NO;
    }
    if (![self.lastNameTextField.text isMinLength:1]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.lastNameNotValid];
        return NO;
    }
    if (![self.emailTextField.text isValidEmail]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.emailNotValid];
        return NO;
    }
    return YES;
}

- (BOOL)isEducations:(NSArray *)firstArray equalTo:(NSArray *)secondArray
{
    if (firstArray.count != secondArray.count){
        return NO;
    }
    for (int i = 0; i < firstArray.count; i++){
        if (![(CCEducation *)firstArray[i] isEqualToEducation:secondArray[i]]){
            return NO;
        }
    }
    return YES;
}

#pragma mark -
#pragma mark Profile Edit Mode Methods
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{

    self.sidePanelController.allowLeftSwipe = !editing;
    [super setEditing:editing animated:animated];
    float duration = animated ? animationDuration : 0;
    
    [UIView animateWithDuration:duration animations:^{
        if (editing){
            [self becomeEditable];
        }
        else {
            [self becomeNotEditable];
        }
    }];
    if (editing) {
        self.arrayOfEducationsBackup = [NSMutableArray arrayWithArray:self.arrayOfEducations];
        [self setLeftNavigationItemWithTitle:@"Cancel" selector:@selector(exitEditProfileButtonDidPressed:)];
        [self setRightNavigationItemWithTitle:@"Save" selector:@selector(saveProfile)];
    }
    else {
        [self.navigationItem setLeftBarButtonItem:self.sideMenuBarButton animated:NO];
        [self setRightNavigationItemWithTitle:@"Edit" selector:@selector(editProfile)];
    }
}

- (void)becomeEditable
{
    [self.mainTable setEditing:YES animated:YES];
    
    self.isEditable = YES;
    self.firstNameTextField.text = self.firstNameLabel.text;
    self.lastNameTextField.text = self.lastNameLabel.text;
    self.emailTextField.text = self.emailLabel.text;
    
    self.firstNameLabel.alpha = 0;
    self.lastNameLabel.alpha = 0;
    self.emailLabel.alpha = 0;
    
    self.myNotesButton.alpha = 0;
    self.mystuffButton.alpha = 0;
    self.logoutButton.alpha = 0;
    self.changePassButton.alpha = 0;
    self.settingsButton.alpha = 0;
    
    self.firstNameTextField.alpha = 1;
    self.lastNameTextField.alpha = 1;
    self.emailTextField.alpha = 1;
    
    self.facebookButton.alpha = 1;
    self.addCollegeButton.alpha = 1;    
}

- (void)becomeNotEditable
{
    [self.mainTable setEditing:NO animated:YES];
    self.isEditable = NO;
    [self.view endEditing:YES];
    
    self.firstNameLabel.alpha = 1;
    self.lastNameLabel.alpha = 1;
    self.emailLabel.alpha = 1;
    
    self.myNotesButton.alpha = 1;
    self.mystuffButton.alpha = 1;
    self.logoutButton.alpha = 1;
    self.changePassButton.alpha = 1;
    self.settingsButton.alpha = 1;
    
    self.firstNameTextField.alpha = 0;
    self.lastNameTextField.alpha = 0;
    self.emailTextField.alpha = 0;
    self.facebookButton.alpha = 0;
    self.addCollegeButton.alpha = 0;
}

#pragma mark -
#pragma mark Requests
- (void)sendUpdatedUserWithSuccess:(successHandler)successHandler
{
    CCUser *updatedUser = [CCUser new];
    updatedUser.firstName = self.firstNameTextField.text;
    updatedUser.lastName = self.lastNameTextField.text;
    updatedUser.email = self.emailTextField.text;
    updatedUser.educations = self.arrayOfEducations.copy;
    
    UIImage *avatarImage = nil;
    
    if (self.isNeedToUploadAvatar){
        avatarImage = self.avatarImageView.image;
    } else {
        updatedUser.avatar = self.facebookAvatarPath;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_apiProvider updateUser:updatedUser withAvatarImage:avatarImage successHandler:^(CCUser *user) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.isNeedToUploadAvatar = NO;
        [self saveUser:user];
        [self setupUserInfo];
        successHandler();
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (IBAction)facebookButtonDidPressed
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_loginAPIProvider linkWithFacebookSuccessHandler:^(id object){
        NSDictionary *facebookUserInfo = object;
        self.ioc_userSession.currentUser.isFacebookLinked = @"true";
        
        if (![self.emailTextField.text isMinLength:1]){
            self.emailTextField.text = facebookUserInfo[CCFacebookKeys.email];
        }
        if (![self.firstNameLabel.text isMinLength:1]){
            self.firstNameTextField.text = facebookUserInfo[CCFacebookKeys.firstName];
        }
        if (![self.lastNameLabel.text isMaxLength:1]){
            self.lastNameTextField.text = facebookUserInfo[CCFacebookKeys.lastName];
        }
        if ([self.ioc_userSession.currentUser.avatar isEqualToString:CCAPIDefines.emptyAvatarPath]){
            self.facebookAvatarPath = [NSString stringWithFormat:CCUserDefines.facebookAvatarLinkTemplate,facebookUserInfo[CCLinkUserKeys.uid]];
            [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.facebookAvatarPath]];
        }
        
        [self.ioc_userSession saveUser];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.facebookButton setHidden:YES];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } facebookSessionCreate:^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTextField){
        [self saveProfile];
    }
    else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}

@end
