//
//  CCSettingController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSettingController.h"
#import "CCSettingsAPIProviderProtocol.h"
#import "CCSettings.h"
#import "CCStandardErrorHandler.h"

@interface CCSettingController ()

@property (nonatomic, strong) IBOutlet UIButton *messageButton;
@property (nonatomic, strong) IBOutlet UIButton *forumsButton;
@property (nonatomic, strong) IBOutlet UIButton *classesButton;
@property (nonatomic, strong) id <CCSettingsAPIProviderProtocol> ioc_settingAPIProvider;
@property (nonatomic, strong) CCSettings *settings;

- (IBAction)didPressedCheckBox:(UIButton *)sender;

@end

@implementation CCSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    [self setRightNavigationItemWithTitle:@"Save" selector:@selector(save)];
    [self loadInfo];
    [self setButtonsClear:@[self.messageButton,self.forumsButton,self.classesButton]];
}

- (void)setButtonsClear:(NSArray *)array
{
    for(UIButton *button in array){
        [button setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"check_active"] forState:UIControlStateSelected];
    }
    
}

- (IBAction)didPressedCheckBox:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)setSettings:(CCSettings *)settings
{
    _settings = settings;
    self.messageButton.selected = self.settings.messagesNotificaitons.boolValue;
    self.forumsButton.selected = self.settings.forumsNotifications.boolValue;
    self.classesButton.selected = self.settings.classesNotifications.boolValue;
}

- (void)loadInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_settingAPIProvider getSettingsSuccessHandler:^(CCSettings *settings) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.settings = settings;
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)save
{
    self.settings.messagesNotificaitons = @(self.messageButton.selected);
    self.settings.forumsNotifications = @(self.forumsButton.selected);
    self.settings.classesNotifications = @(self.classesButton.selected);
    [self.ioc_settingAPIProvider uploadSettings:self.settings successHandler:^(id result) {
        [SVProgressHUD showSuccessWithStatus:@"Successfuly Updated!"];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
