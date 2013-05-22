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

@interface CCLoginController ()

@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UITextField *passField;

@end

@implementation CCLoginController

- (IBAction)loginButtonDidPressed
{
    if([self isFormValid]){
        
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

@end
