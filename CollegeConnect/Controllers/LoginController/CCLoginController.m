//
//  CCLoginController.m
//  CollegeConnect
//
//  Created by Vlad Korzun on 21.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLoginController.h"
#import "CCLoginAPIProviderProtocol.h"

@interface CCLoginController ()

@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;

@end

@implementation CCLoginController


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

}

- (IBAction)emailSignUPButtonDidPressed
{
    [self.signUpTransaction perform];
}

@end
