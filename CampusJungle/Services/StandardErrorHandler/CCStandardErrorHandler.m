//
//  CCStandardErrorHandler.m
//  CampusJungle
//
//  Created by Vlad Korzun on 27.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStandardErrorHandler.h"
#import "JSONKit.h"

#import "GIAlert.h"

@implementation CCStandardErrorHandler

+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message
{
    GIAlertButton *alertButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.okButton action:nil];
    GIAlert *alert = [GIAlert alertWithTitle:title message:message buttons:@[alertButton]];
    [alert show];
}

+ (void)showErrorWithCode:(NSInteger)code
{
    switch (code) {
        case 401:
        {
            [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error
                                               message:CCAlertsMessages.authorizationFaild];
        }
            break;
        case -1011:
        {
            [CCStandardErrorHandler showErrorWithTitle:nil message:CCAlertsMessages.serverUnavailable];
        }
            break;
        default:
            break;
    }

}

+ (void)showErrorWithError:(NSError *)error
{
    NSString *responseErrorDictionary = [error.userInfo objectForKey:CCErrorKeys.localizedRecoverySuggestion];
    
    NSString *errorMessage = [responseErrorDictionary objectFromJSONString][CCErrorKeys.errorMessage];
    
    if (errorMessage){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error
                                           message:errorMessage];
    } else {
        [CCStandardErrorHandler showErrorWithCode:error.code];
    }
}

@end
