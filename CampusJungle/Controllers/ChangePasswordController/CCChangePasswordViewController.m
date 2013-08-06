//
//  CCChangePasswordViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCChangePasswordViewController.h"
#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"
#import "NSString+CJStringValidator.h"
#import "CCStandardErrorHandler.h"
#import "CCAPIProviderProtocol.h"
#import "CCKeyboardHelper.h"

@interface CCChangePasswordViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordConfirmationTextField;

@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCChangePasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setRightNavigationItemWithTitle:@"Save" selector:@selector(saveButtonDidPressed:)];
    [self setTitle:@"New Password"];
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

#pragma mark -
#pragma mark Actions
- (void)saveButtonDidPressed:(id)sender
{
    [CCKeyboardHelper hideKeyboard];
    if ([self validateInputData]) {
        [self setNewPassword:self.passwordTextField.text withConfirmation:self.passwordConfirmationTextField.text];
    }
}

#pragma mark -
#pragma mark Input Data Validation
- (BOOL)validateInputData
{
    if ([self.passwordTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyPassword];
        return NO;
    }
    if (![self.passwordTextField.text isMinLength:CCUserDefines.minimumPasswordLength]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.passNotValid];
        return NO;
    }
    if (![self.passwordTextField.text isEqualToString:self.passwordConfirmationTextField.text]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.passwordAndConfirmationDoNotMatched];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Requests
- (void)setNewPassword:(NSString *)password withConfirmation:(NSString *)confirmation
{
    NSDictionary *params = @{@"password" : password, @"password_confirmation" : confirmation};
    __weak CCChangePasswordViewController *weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_apiProvider changePasswordWithParams:params successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.passwordChanged duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];        
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.passwordTextField) {
        [self.passwordConfirmationTextField becomeFirstResponder];
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
