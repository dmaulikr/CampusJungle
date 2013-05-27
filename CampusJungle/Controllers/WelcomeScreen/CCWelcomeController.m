//
//  CCLoginController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCWelcomeController.h"
#import "CCLoginAPIProviderProtocol.h"
#import "CCUserSessionProtocol.h"
#import "CCAuthorizationResponse.h"
#import "CCAlertDefines.h"

@interface CCWelcomeController ()

@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCWelcomeController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)facebookLoginButtonDidPressed
{
    [self.ioc_loginAPIProvider performLoginOperationViaFacebookWithSuccessHandler:^(id authorizationResponse){
        if([[authorizationResponse isFirstLaunch] isEqualToString:@"true"]){
            [self.initialUserInfoTransaction perform];
        } else {
            [self.loginTransaction perform];
        }
    } errorHandler:^(NSError * error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:CCAlertsMessages.error message:CCAlertsMessages.facebookError delegate:nil cancelButtonTitle:CCAlertsButtons.okButton otherButtonTitles: nil];
        [alertView show];
    }];
}

- (IBAction)emailLoginButtonDidPressed
{
    [self.loginScreenTransaction perform];
}

- (IBAction)emailSignUPButtonDidPressed
{
    [self.signUpTransaction perform];
}

@end