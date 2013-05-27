//
//  CCLoginController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 22.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginController.h"
#import "NSString+CJStringValidator.h"
#import "CCAlertDefines.h"
#import "CCLoginAPIProviderProtocol.h"
#import "CCDefines.h"
#import "CCUserSessionProtocol.h"
#import "MBProgressHUD.h"

@interface CCLoginController ()

@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passField;
@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;

@end

@implementation CCLoginController

- (IBAction)loginButtonDidPressed
{
    if([self isFormValid]){
        NSDictionary *userInfoDictionary = @{
                                             CCUserSignUpKeys.email : self.emailField.text,
                                             CCUserSignUpKeys.password : self.passField.text
                                             };
        
        [self.ioc_loginAPIProvider performLoginOperationWithUserInfo:userInfoDictionary successHandler:^{
            [self.loginTransaction perform];
        
        } errorHandler:^(NSError *error) {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:CCAlertsMessages.error message: CCAlertsMessages.wrongEmailOfPassword delegate:nil cancelButtonTitle:CCAlertsButtons.okButton otherButtonTitles: nil];
            [errorAlert show];
        }];
        
    } else {
        UIAlertView *alertOnNotValidFields = [[UIAlertView alloc] initWithTitle:nil message:CCAlertsMessages.formNotValid delegate:self cancelButtonTitle:CCAlertsButtons.okButton otherButtonTitles: nil];
        [alertOnNotValidFields show];
    }
}

- (BOOL)isFormValid
{
    BOOL isFormValid = YES;
    
    if (![self.emailField.text isEmail]) isFormValid = NO;
    if (![self.passField.text isMinLength:3]) isFormValid = NO;
    
    return isFormValid;
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
