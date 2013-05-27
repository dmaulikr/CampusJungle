//
//  CCAlertDefines.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAlertDefines.h"

const struct CCAlertsMessages CCAlertsMessages = {
    .connectToTheInternet = @"You must be connected to the internet to use this app.",
    .serverUnavailable = @"Server is temporarily unavailable. Please try again later.",
    .noInternetConnection = @"No network connection",
    .formNotValid = @"Form is not valid",
    .error = @"Error",
    .facebookError = @"Facebook authorization faild",
    .wrongEmailOfPassword = @"Wrong email or password",
    .authorizationFaild = @"Authorization Faild",
    .confimAlert = @"Are you sure?",
};

const struct CCAlertsButtons CCAlertsButtons = {
    .okButton = @"Ok",
    .cancelButton= @"Cancel",
    .yesButton = @"Yes",
    .noButton = @"No"
};