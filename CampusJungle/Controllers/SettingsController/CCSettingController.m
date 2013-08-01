//
//  CCSettingController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSettingController.h"

@interface CCSettingController ()

@property (nonatomic, strong) IBOutlet UIButton *messageButton;
@property (nonatomic, strong) IBOutlet UIButton *forumsButton;
@property (nonatomic, strong) IBOutlet UIButton *classesButton;

- (IBAction)didPressedCheckBox:(UIButton *)sender;

@end

@implementation CCSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    [self setbuttonsClear:@[self.messageButton,self.forumsButton,self.classesButton]];
}

- (void)setbuttonsClear:(NSArray *)array
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

@end
