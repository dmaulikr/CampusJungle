//
//  CCInitialUserInfoControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 19.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInitialUserInfoController.h"
#import "CCUserSessionProtocol.h"
#import "CCButtonsHelper.h"
#import "CCAPIProviderProtocol.h"
#import "NSString+CJStringValidator.h"
#import "CCAvatarSelectionActionSheet.h"
#import "NSString+CCValidationHelper.h"
#import "CCLoginAPIProviderProtocol.h"

@interface CCInitialUserInfoController ()<CCAvatarSelectionProtocol>

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, weak) IBOutlet UITextField *firstNameFiled;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UIButton *avatarButton;
@property (nonatomic, strong) CCUser *currentUser;
@property (nonatomic) BOOL isAvatarChanged;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, strong) CCAvatarSelectionActionSheet *avatarSelectionSheet;
@property (nonatomic, weak) IBOutlet UIButton *facebookButton;
@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;

- (IBAction)avatarButtonDidPressed;

@end

@implementation CCInitialUserInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpInfo];
    [self setRightNavigationItemWithTitle:@"Done" selector:@selector(done)];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]]];
    self.avatarSelectionSheet = [CCAvatarSelectionActionSheet new];
    self.avatarSelectionSheet.delegate = self;
    self.title = @"User Info";
    if(![self isFacebookButtonNeeaded]){
        self.facebookButton.hidden = YES;
    }
}

- (void)setUpInfo
{
    self.currentUser = [self.ioc_userSession currentUser];
    self.firstNameFiled.text = self.currentUser.firstName;
    self.lastNameField.text = self.currentUser.lastName;
    self.emailField.text = self.currentUser.email;
    
    NSString *avatarPath = [CCAPIDefines.baseURL stringByAppendingString:self.currentUser.avatar];
    [self.avatar setImageWithURL:[NSURL URLWithString:avatarPath] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    [CCButtonsHelper removeBackgroundImageInButton:self.avatarButton];
}


- (void)done
{
    if([self validate]){
        self.currentUser.firstName = self.firstNameFiled.text;
        self.currentUser.lastName = self.lastNameField.text;
        self.currentUser.email = self.emailField.text;
        
        UIImage *avatar = nil;
        if (self.isAvatarChanged){
            avatar = self.avatar.image;
        } 
        if(!self.currentUser.avatar.length){
            self.currentUser.avatar = nil;
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.ioc_apiProvider updateUser:self.currentUser
                         withAvatarImage:avatar successHandler:^(CCUser *result) {
                             [self.ioc_userSession setCurrentUser:result];
                             [self.loginTrnasaction perform];
                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                         } errorHandler:^(NSError *error) {
                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                             [CCStandardErrorHandler showErrorWithError:error];
                         }];
    }
}

- (IBAction)avatarButtonDidPressed
{
    [self.view endEditing:YES];
    [self.avatarSelectionSheet showWithTitle:@"Select Photo" takePhotoButtonTitle:nil takeFromGalleryButtonTitle:nil];
}

- (BOOL)validate
{
    if (![self.firstNameFiled.text isMinLength:1]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.firstNameNotValid];
        return NO;
    }
    if (![self.lastNameField.text isMinLength:1]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.lastNameNotValid];
        return NO;
    }
    if (![self.emailField.text isValidEmail]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.emailNotValid];
        return NO;
    }
    return YES;
}

- (BOOL)isFacebookButtonNeeaded
{
    CCUser *user = [self.ioc_userSession currentUser];
    if(user.lastName.isEmpty) return YES;
    if(user.firstName.isEmpty) return YES;
    if(user.avatar.isEmpty) return YES;
    if(user.email.isEmpty) return YES;
    return NO;
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.avatar.image = avatar;
    self.isAvatarChanged = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.emailField){
        [self done];
    } else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}

- (IBAction)facebookButtonDidPressed
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_loginAPIProvider linkWithFacebookSuccessHandler:^(id object){
        NSDictionary *facebookUserInfo = object;
        self.ioc_userSession.currentUser.isFacebookLinked = @YES;
        
        if (![self.emailField.text isMinLength:1]){
            self.emailField.text = facebookUserInfo[CCFacebookKeys.email];
        }
        if (![self.firstNameFiled.text isMinLength:1]){
            self.firstNameFiled.text = facebookUserInfo[CCFacebookKeys.firstName];
        }
        if (![self.lastNameField.text isMaxLength:1]){
            self.lastNameField.text = facebookUserInfo[CCFacebookKeys.lastName];
        }
        [self.avatar setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:CCUserDefines.facebookAvatarLinkTemplate,facebookUserInfo[CCLinkUserKeys.uid]]]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.facebookButton setHidden:YES];
        self.isAvatarChanged = YES;
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } facebookSessionCreate:^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }];
}


@end
