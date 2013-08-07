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
#import "CCStandardErrorHandler.h"
#import "CCTwitterPicker.h"
#import "MBProgressHUD.h"

@interface CCWelcomeController ()

@property (nonatomic, strong) id <CCLoginAPIProviderProtocol> ioc_loginAPIProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@property (nonatomic, strong) IBOutlet UIButton *loginButton;
@property (nonatomic, strong) IBOutlet UIButton *signupButton;
@property (nonatomic, strong) IBOutlet UIButton *facebookButton;
@property (nonatomic, strong) IBOutlet UIButton *twitterButton;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation CCWelcomeController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationDidEnterForeground)
     name:CCAppDelegateDefines.notificationOnBackToForeground
     object:nil];
    [self setImagesNamed:@"login_button" activeName:@"loginButtonPressed" ForButton:self.loginButton];
    [self setImagesNamed:@"login_button" activeName:@"loginButtonPressed" ForButton:self.twitterButton];
    [self setImagesNamed:@"login_button" activeName:@"loginButtonPressed" ForButton:self.facebookButton];
    [self setImagesNamed:@"loginButtonPressed" activeName:@"login_button" ForButton:self.signupButton];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setImagesNamed:(NSString *)name activeName:(NSString *)activeName ForButton:(UIButton *)button
{
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:activeName] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:19];

}

- (void)applicationDidEnterForeground
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView flashScrollIndicators];
}

- (IBAction)facebookLoginButtonDidPressed
{
    [self loading:YES];
    [self.ioc_loginAPIProvider performLoginOperationViaFacebookWithSuccessHandler:^(id authorizationResponse){
        [self processResponse:authorizationResponse];
        [self loading:NO];
    } errorHandler:^(NSError * error) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error
                                           message:CCAlertsMessages.facebookError];
        [self loading:NO];
    } facebookSessionCreate:^{
        [self loading:YES]; 
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

- (IBAction)twitterLoginButtonPressed
{
    [CCTwitterPicker showTwitterAccountSelectionInView:self.view
                                     startLoadingBlock:^{
                               [self loading:YES];
                             } fetchInfoSuccessHandler:^(id response) {
        [self.ioc_loginAPIProvider performLoginOperationViaTwitterWithUserInfo:response SuccessHandler:^(id authorizationResponse) {
            [self processResponse:authorizationResponse];
            [self loading:NO];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
            [self loading:NO];
        }];
    } errorHandler:^(NSError *error) {
        if (error.code > 0) {
            [CCStandardErrorHandler showErrorWithError:error];
        }
        [self loading:NO];
    }];
}

- (void)processResponse:(CCAuthorizationResponse *)response
{
    if([[response isFirstLaunch] isEqualToString:@"true"]){
        [self.initialUserInfoTransaction perform];
    } else {
        [self.loginTransaction perform];
    }
}

- (void)loading:(BOOL)loading
{
    if(loading){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    } else {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

@end
