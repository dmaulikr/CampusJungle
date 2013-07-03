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
#import "CCDefines.h"
#import "CCAlertDefines.h"
#import "CCTransaction.h"
#import "CCStandardErrorHandler.h"

@interface CCSignUPController ()

@property (nonatomic, weak) IBOutlet UITextField *firstNameField;
@property (nonatomic, weak) IBOutlet UITextField *lastNameField;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passField;

@property (nonatomic, strong) id <CCSignUPAPIProtocol> ioc_signUpAPI;

@end

@implementation CCSignUPController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(saveButtonDidPressed)];
    self.navigationItem.rightBarButtonItem = saveButton;

   
    self.tapRecognizer.enabled = YES;
}

- (void)saveButtonDidPressed
{
    if([self isFormValid]){
        NSDictionary *userFields = @{
                                     CCUserSignUpKeys.email : self.emailField.text,
                                     CCUserSignUpKeys.password :self.passField.text
                                     };
        [self.ioc_signUpAPI signUpWithUserDictionary:userFields successHandler:^{
            [self.initialUserProfileTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
        
    } else {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error
                                           message:CCAlertsMessages.formNotValid];
    }
}

- (BOOL)isFormValid
{
    if (![self.emailField.text isEmail]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCValidationMessages.emailNotValid];
        return NO;
    }
    if (![self.passField.text isMinLength:CCUserDefines.minimumPasswordLength]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCValidationMessages.passNotValid];
        return NO;
    }

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.passField){
        [self saveButtonDidPressed];
    } else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}

@end
