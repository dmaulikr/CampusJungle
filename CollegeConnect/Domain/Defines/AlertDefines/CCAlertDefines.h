//
//  CCAlertDefines.h
//  CollegeConnect
//
//  Created by Vlad Korzun on 15.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct CCAlertsMessages {
    __unsafe_unretained NSString *noInternetConnection;
    __unsafe_unretained NSString *serverUnavailable;
    __unsafe_unretained NSString *connectToTheInternet;
    __unsafe_unretained NSString *formNotValid;
    __unsafe_unretained NSString *error;
    __unsafe_unretained NSString *facebookError;
} CCAlertsMessages;

extern const struct CCAlertsButtons {
    __unsafe_unretained NSString *okButton;
    __unsafe_unretained NSString *cancelButton;
} CCAlertsButtons;
