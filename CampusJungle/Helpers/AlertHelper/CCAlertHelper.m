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
    [self showWithMessage:message successButtonTitle:CCAlertsButtons.yesButton cancelButtonTitle:CCAlertsButtons.noButton success:success];
}

+ (void)showWithMessage:(NSString *)message successButtonTitle:(NSString *)successButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle success:(successHandler)success
{
    GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:cancelButtonTitle action:nil];
    GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:successButtonTitle action:success];
    
    GIAlert *alert = [GIAlert alertWithTitle:CCAlertsMessages.confirmation
                                     message:message
                                     buttons:@[noButton, yesButton]];
    [alert show];
}

@end
