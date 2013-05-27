//
//  CCStandardErrorHandler.m
//  CampusJungle
//
//  Created by Vlad Korzun on 27.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStandardErrorHandler.h"
#import "CCAlertDefines.h"
#import "JSONKit.h"
#import "CCDefines.h"

@implementation CCStandardErrorHandler

+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:CCAlertsButtons.okButton
                                          otherButtonTitles:nil];
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
            
        default:
            break;
    }

}

+ (void)showErrorWithError:(NSError *)error
{
    NSString *responseErrorDictionary = [error.userInfo objectForKey:CCErrorKeys.localizedRecoverySuggestion];
    
    NSString *errorMessage = [responseErrorDictionary objectFromJSONString][CCErrorKeys.errorMessage];
    
    [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error
                                       message:errorMessage];
}

@end
