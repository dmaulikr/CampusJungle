//
//  CCAlertHelper.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAlertHelper.h"
#import "GIAlertButton.h"
#import "GIAlert.h"

@implementation CCAlertHelper

+ (void)showConfirmWithSuccess:(successHandler)success
{
    [self showWithMessage:CCAlertsMessages.confirmationMessage success:success];
}

+ (void)showWithMessage:(NSString *)message success:(successHandler)success
{
    [self showWithTitle:CCAlertsMessages.confirmation message:message successButtonTitle:CCAlertsButtons.yesButton cancelButtonTitle:CCAlertsButtons.noButton success:success];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message successButtonTitle:(NSString *)successButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle success:(successHandler)success
{
    GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:cancelButtonTitle action:nil];
    GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:successButtonTitle action:success];
    
    GIAlert *alert = [GIAlert alertWithTitle:title
                                     message:message
                                     buttons:@[noButton, yesButton]];
    [alert show];
}

+ (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message
{
    GIAlertButton *alertButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.okButton action:nil];
    GIAlert *alert = [GIAlert alertWithTitle:title message:message buttons:@[alertButton]];
    [alert show];
}

@end
