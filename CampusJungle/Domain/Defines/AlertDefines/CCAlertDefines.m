//
//  CCAlertDefines.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAlertDefines.h"

const struct CCAlertsMessages CCAlertsMessages = {
    .connectToTheInternet = @"You must be connected to the internet to use this app",
    .serverUnavailable = @"Server is temporarily unavailable. Please try again later",
    .noInternetConnection = @"There is no network connection",
    .formNotValid = @"Form is not valid",
    .error = @"Error",
    .success = @"Success",
    .facebookError = @"Facebook authorization failed",
    .wrongEmailOfPassword = @"Wrong email or password",
    .authorizationFaild = @"Authorization failed",
    .confimAlert = @"Are you sure?",
    .emailNotValid = @"Email isn't valid",
    .firstNameNotValid = @"First name can't be empty",
    .lastNameNotValid = @"Last name can't be empty",
    .createCollege = @"In order to join class you should select your college first",
    .dropboxLinkingFaild = @"Dropbox linking failed",
    .emptyField = @"Please fill in all fields",
    .setEmailFirst = @"Set your email in user profile first",
    .confirmation = @"Confirmation",
    .confirmationMessage = @"Are you sure?",
    .checkYourMail = @"Check your email box",
    .noteNotReadyForView = @"This note isn't ready for review. Try again later.",
    .haveNoClassesInSelectedCollege = @"You haven't classes in selected college",
};

const struct CCAlertsButtons CCAlertsButtons = {
    .okButton = @"Ok",
    .cancelButton= @"Cancel",
    .yesButton = @"Yes",
    .noButton = @"No"
};

const struct CCAlertsTitles CCAlertsTitles = {
    .requestError = @"Request failed",
    .defaultError = @"Error",
    .logOut = @"Log Out",
};

const struct CCValidationMessages CCValidationMessages = {
    .emailNotValid = @"Email is not valid",
    .passNotValid = @"Password is to short",
    .firstNameCantBeBlank = @"First name can't be blank",
    .lastNameCantBeBlank = @"Last name can't be blank",
    .priceCantBeBlank = @"Price can't be blank",
    .fullPriceCantBeBlank = @"Full access price can't be blank",
    .fullPriceCantBeLowerThenPriceForReview = @"Full access price can't be lower than price for review",
    .descriptionCantBeBlank = @"Description can't be blank",
    .filterCanNotBeEmpty = @"Filter can't be empty",
};
