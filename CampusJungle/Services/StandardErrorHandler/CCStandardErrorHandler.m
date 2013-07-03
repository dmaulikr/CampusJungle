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
#import "GIAlert.h"

@implementation CCStandardErrorHandler

+ (void)showErrorWithTitle:(NSString *)title message:(NSString *)message
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                    message:message
//                                                   delegate:self
//                                          cancelButtonTitle:CCAlertsButtons.okButton
//                                          otherButtonTitles:nil];
    
    GIAlertButton *alertButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.okButton action:nil];
    GIAlert *alert = [GIAlert alertWithTitle:title message:message buttons:@[alertButton]];
    [alert show];
    
    //[alert show];
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
    
    if (errorMessage){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error
                                           message:errorMessage];
    } else {
        [CCStandardErrorHandler showErrorWithCode:error.code];
    }
}

@end
