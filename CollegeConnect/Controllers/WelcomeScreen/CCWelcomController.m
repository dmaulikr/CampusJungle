//
//  CCLoginController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCWelcomeController.h"
#import "CCLoginAPIProviderProtocol.h"

@interface CCWelcomeController ()

@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;

@end

@implementation CCWelcomeController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)facebookLoginButtonDidPressed
{
    [self.ioc_loginAPIProvider performLoginOperationViaFacebookWithSuccessHandler:^{
        
    } errorHandler:^(NSError * error) {
        
    }];
}

- (IBAction)twitterLoginButtonDidPressed
{

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
