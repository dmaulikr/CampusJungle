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
    .success = @"Success",
    .facebookError = @"Facebook authorization faild",
    .wrongEmailOfPassword = @"Wrong email or password",
    .authorizationFaild = @"Authorization Faild",
    .confimAlert = @"Are you sure?",
    .emailNotValid = @"Email not valid",
    .firstNameNotValid = @"First name can not be empty",
    .lastNameNotValid = @"Last name can not be empty",
    .createCollege = @"In order to join class you should select your college first.",
    .dropboxLinkingFaild = @"Dropbox linking faild",
    .emptyField = @"Please, fill in all fields",
    .setEmailFirst = @"Set your email in user profile first",
    .confirmation = @"Confirmation",
    .confirmationMessage = @"Are you sure?",
    .checkYourMail = @"Check your email box",
    .noteNotReadyForView = @"This note not ready for review. Try again later.",
};

const struct CCAlertsButtons CCAlertsButtons = {
    .okButton = @"Ok",
    .cancelButton= @"Cancel",
    .yesButton = @"Yes",
    .noButton = @"No"
};

const struct CCAlertsTitles CCAlertsTitles = {
    .requestError = @"Request failed",
};

const struct CCValidationMessages CCValidationMessages = {
    .emailNotValid = @"Email not valid",
    .passNotValid = @"Password to short",
    .firstNameCantBeBlank = @"First name can not be blank",
    .lastNameCantBeBlank = @"Last name can not be blank",
    .priceCantBeBlank = @"Price can not be blank",
    .fullPriceCantBeBlank = @"Full access price can not be blank",
    .fullPriceCantBeLowerThenPriceForReview = @"Full access price can not be lower then price for review",
    .descriptionCantBeBlank = @"Description can not be blank",
    .filterCanNotBeEmpty = @"Filter can not be empty",
};
