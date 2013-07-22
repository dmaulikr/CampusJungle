//
//  CCSingUPControllerViewController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSignUPController.h"
#import "NSString+CJStringValidator.h"
#import "CCSignUPAPIProtocol.h"
#import "CCTransaction.h"
#import "CCStandardErrorHandler.h"
#import "NSString+CCValidationHelper.h"

@interface CCSignUPController ()

@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passField;

@property (nonatomic, strong) id <CCSignUPAPIProtocol> ioc_signUpAPI;

@end

@implementation CCSignUPController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tapRecognizer.enabled = YES;
    [self setRightNavigationItemWithTitle:@"Save" selector:@selector(saveButtonDidPressed)];
    self.title = @"Sign Up";
}

- (void)saveButtonDidPressed
{
    if ([self isFormValid]){
        NSDictionary *userFields = @{
                                     CCUserSignUpKeys.email : self.emailField.text,
                                     CCUserSignUpKeys.password :self.passField.text
                                     };
        [self.ioc_signUpAPI signUpWithUserDictionary:userFields successHandler:^{
            [self.initialUserProfileTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
        
    }
}

- (BOOL)isFormValid
{
    if ([self.emailField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyEmail];
        return NO;
    }
    if (![self.emailField.text isValidEmail]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emailNotValid];
        return NO;
    }
    if ([self.passField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyPassword];
        return NO;
    }
    if (![self.passField.text isMinLength:CCUserDefines.minimumPasswordLength]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.passNotValid];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.passField) {
        [self saveButtonDidPressed];
    }
    else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
    }
    return YES;
}

@end
