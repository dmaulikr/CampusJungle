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
    GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.noButton action:nil];
    GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.yesButton action:success];
    
    GIAlert *alert = [GIAlert alertWithTitle:CCAlertsMessages.confirmation
                                     message:CCAlertsMessages.confirmationMessage
                                     buttons:@[noButton, yesButton]];
    [alert show];
}

@end
