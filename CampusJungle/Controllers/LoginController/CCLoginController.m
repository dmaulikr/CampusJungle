//
//  CCLoginController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginController.h"
#import "NSString+CJStringValidator.h"
#import "CCLoginAPIProviderProtocol.h"
#import "CCUserSessionProtocol.h"
#import "CCStandardErrorHandler.h"
#import "UITextField+InsetFixing.h"


@interface CCLoginController ()

@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passField;
@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;

@end

@implementation CCLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tapRecognizer.enabled = YES;
    self.title = @"Login";
}

- (IBAction)loginButtonDidPressed
{
    if([self isFormValid]){
        NSDictionary *userInfoDictionary = @{
                                             CCUserSignUpKeys.email : self.emailField.text,
                                             CCUserSignUpKeys.password : self.passField.text
                                             };
        
        [self.ioc_loginAPIProvider performLoginOperationWithUserInfo:userInfoDictionary
                                                      successHandler:^{
            [self.loginTransaction perform];
        
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
    if (![self.emailField.text isEmail]){
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.passField){
        [self loginButtonDidPressed];
    } else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}

@end
