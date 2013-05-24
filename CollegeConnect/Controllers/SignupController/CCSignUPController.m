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

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonDidPressed)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void)saveButtonDidPressed
{
    if([self isFormValid]){
        NSDictionary *userFields = @{
                                     CCUserSignUpKeys.firstName : self.firstNameField.text,
                                     CCUserSignUpKeys.lastName : self.lastNameField.text,
                                     CCUserSignUpKeys.email : self.emailField.text,
                                     CCUserSignUpKeys.password :self.passField.text
                                     };
        [self.ioc_signUpAPI signUpWithUserDictionary:userFields successHandler:^{
        
        [self.initialUserProfileTransaction perform];
            
        } errorHandler:^(NSError *error) {
            
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
    if ( [self.firstNameField.text isEmpty]) isFormValid = NO;
    if ( [self.lastNameField.text isEmpty]) isFormValid = NO;
    if (![self.passField.text isMinLength:3]) isFormValid = NO;

    return isFormValid;
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
