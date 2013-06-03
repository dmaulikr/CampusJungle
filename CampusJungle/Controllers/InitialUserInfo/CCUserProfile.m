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
#import "CCDefines.h"
#import "CCEducationCell.h"
#import "CCEducationsDataProvider.h"
#import "CCLoginAPIProvider.h"
#import "CCStandardErrorHandler.h"
#import "MBProgressHUD.h"
#import "NSString+CJStringValidator.h"
#import "UIActionSheet+BlocksKit.h"
#import "UIAlertView+BlocksKit.h"
#import "CCEducation.h"

#define animationDuration 0.4

@interface CCUserProfile () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *firstName;
@property (nonatomic, weak) IBOutlet UILabel *lastName;
@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UIView *tableFooterView;
@property (nonatomic, weak) IBOutlet UIView *tableHeaderView;

@property (nonatomic, weak) IBOutlet UIButton *addCollegeButton;

@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UIButton *facebookButton;

@property (nonatomic, strong) CCEducationsDataProvider *dataProvider;

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic) BOOL isEditable;
@property (nonatomic) BOOL isNeedToUploadAvatar;

@property (nonatomic, strong) NSString *facebookAvatarPath;

@end

@implementation CCUserProfile

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainTable.tableFooterView = self.tableFooterView;
    self.mainTable.tableHeaderView = self.tableHeaderView;
    
    [self setupUserInfo];
    if([[[self.ioc_userSession currentUser] isFacebookLinked] isEqualToString:@"true"]){
        [self.facebookButton setHidden:YES];
    }
    
    [self configTable];

    [self setRightNavigationItemWithTitle:@"Edit" selector:@selector(edit)];
    self.facebookButton.alpha = 0;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationDidEnterForeground)
     name:CCAppDelegateDefines.notificationOnBackToForeground
     object:nil];
}

- (void)applicationDidEnterForeground
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)setupUserInfo
{
    self.firstName.text = [[self.ioc_userSession currentUser] firstName];
    self.lastName.text = [[self.ioc_userSession currentUser] lastName];
    self.email.text = [[self.ioc_userSession currentUser] email];
    
    [self.arrayOfEducations removeAllObjects];
    for (CCEducation * education in self.ioc_userSession.currentUser.educations){
        [self.arrayOfEducations addObject:education];
    }
    [self.dataProvider loadItems];
    if(![[[self.ioc_userSession currentUser] avatar] isEqualToString:CCAPIDefines.emptyAvatarPath]){
        NSString *avatarURL = [NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,[[self.ioc_userSession currentUser] avatar]];
        [self.avatar setImageWithURL:[NSURL URLWithString:avatarURL]];
    }
}

- (void)configTable
{
    self.dataProvider = [CCEducationsDataProvider new];
    self.dataProvider.arrayOfEducations = self.arrayOfEducations;
    [self configTableWithProvider:self.dataProvider cellClass:[CCEducationCell class]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mainTable reloadData];
}

- (IBAction)logout
{
    UIAlertView *testView = [UIAlertView alertViewWithTitle:nil message:CCAlertsMessages.confimAlert];
    [testView addButtonWithTitle:CCAlertsButtons.yesButton handler:^{
        [self.logoutTransaction perform];
    }];
	[testView addButtonWithTitle:CCAlertsButtons.noButton handler:nil];
	[testView show];
}

- (void)edit
{
    [self setEditing:YES animated:YES];
    [self setRightNavigationItemWithTitle:@"Save" selector:@selector(save)];
}

- (void)save
{
    if([self isFieldsValid]){
        [self setEditing:NO animated:YES];
        [self setRightNavigationItemWithTitle:@"Edit" selector:@selector(edit)];
        [self sendUpdatedUser];
    }
}

- (BOOL)isFieldsValid
{
    if (![self.firstNameField.text isMinLength:1]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.firstNameNotValid];
        return NO;
    }
    if (![self.lastNameField.text isMinLength:1]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.lastNameNotValid];
        return NO;
    }
    if (![self.emailField.text isEmail]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.emailNotValid];
        return NO;
    }
    return YES;
}

- (void)sendUpdatedUser
{
    CCUser *updatedUser = [CCUser new];
    updatedUser.firstName = self.firstNameField.text;
    updatedUser.lastName = self.lastNameField.text;
    updatedUser.email = self.emailField.text;
    updatedUser.educations = self.arrayOfEducations.copy;
    
    UIImage *avatarImage = nil;
    
    if (self.isNeedToUploadAvatar){
        avatarImage = self.avatar.image;
    } else {
        updatedUser.avatar = self.facebookAvatarPath;
    }
    
    [self.ioc_apiProvider updateUser:updatedUser withAvatarImage:avatarImage SuccessHandler:^(CCUser *user) {
        self.isNeedToUploadAvatar = NO;
        user.token = [self.ioc_userSession.currentUser token];
        user.isFacebookLinked = [self.ioc_userSession.currentUser isFacebookLinked];
        self.ioc_userSession.currentUser = user;
        [self setupUserInfo];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
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
    self.isEditable = YES;
    self.firstNameField.text = self.firstName.text;
    self.lastNameField.text = self.lastName.text;
    self.emailField.text = self.email.text;
    
    self.firstName.alpha = 0;
    self.lastName.alpha = 0;
    self.email.alpha = 0;
    
    self.firstNameField.alpha = 1;
    self.lastNameField.alpha = 1;
    self.emailField.alpha = 1;
    
    self.facebookButton.alpha = 1;
    self.addCollegeButton.alpha = 1;
}

- (void)becomeNotEditable
{
    self.isEditable = NO;
    [self.view endEditing:YES];
    
    self.firstName.alpha = 1;
    self.lastName.alpha = 1;
    self.email.alpha = 1;
    
    self.firstNameField.alpha = 0;
    self.lastNameField.alpha = 0;
    self.emailField.alpha = 0;
    self.facebookButton.alpha = 0;
    self.addCollegeButton.alpha = 0;
}

- (IBAction)addCollegeButtonDidPressed
{
    [self.addColegeTransaction perform];
}

- (IBAction)facebookButtonDidPressed
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_loginAPIProvider linkWithFacebookSuccessHandler:^(id object){
        NSDictionary *facebookUserInfo = object;
        self.ioc_userSession.currentUser.isFacebookLinked = @"true";
        
        if(![self.emailField.text isMinLength:1]){
            self.emailField.text = facebookUserInfo[CCFacebookKeys.email];
        }
        if(![self.firstName.text isMinLength:1]){
            self.firstNameField.text = facebookUserInfo[CCFacebookKeys.firstName];
        }
        if(![self.lastName.text isMaxLength:1]){
            self.lastNameField.text = facebookUserInfo[CCFacebookKeys.lastName];
        }
        if([self.ioc_userSession.currentUser.avatar isEqualToString:CCAPIDefines.emptyAvatarPath]){
            self.facebookAvatarPath = [NSString stringWithFormat:CCUserDefines.facebookAvatarLinkTemplate,facebookUserInfo[CCLinkUserKeys.uid]];
            [self.avatar setImageWithURL:[NSURL URLWithString:self.facebookAvatarPath]];
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

- (IBAction)avatarDidPressed
{
    if(self.isEditable){
        UIActionSheet *testSheet = [UIActionSheet actionSheetWithTitle:@"Select Avatar"];
        [testSheet addButtonWithTitle:@"Select from gallery" handler:^{
            [self selectAvatarFromGallery];
        }];
        [testSheet addButtonWithTitle:@"Make photo" handler:^{
            [self makePhotoForAvatar];
        }];
        [testSheet setCancelButtonWithTitle:nil handler:nil];
        [testSheet showInView:self.view];
    }
}

- (void)selectAvatarFromGallery
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)makePhotoForAvatar
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.avatar.image = info[UIImagePickerControllerEditedImage];
    self.isNeedToUploadAvatar = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
