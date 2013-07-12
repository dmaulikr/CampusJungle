//
//  CCClassTabbarControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassTabbarControllerViewController.h"
#import "CCDefines.h"

@interface CCClassTabbarControllerViewController ()

@property (nonatomic, weak) IBOutlet UIButton *classmatesButton;
@property (nonatomic, weak) IBOutlet UIButton *groupsButton;
@property (nonatomic, weak) IBOutlet UIButton *locationButton;
@property (nonatomic, weak) IBOutlet UIButton *forumsButton;

@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic, weak) UIButton *currentlySelected;

- (IBAction)didSelectButton:(UIButton *)sender;

@end

@implementation CCClassTabbarControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttons = @[self.classmatesButton,self.groupsButton,self.locationButton,self.forumsButton];
    self.classmatesButton.tag = CCClassTabbarButtonsIdentifierClassmate;
    self.groupsButton.tag = CCClassTabbarButtonsIdentifierGroup;
    self.locationButton.tag = CCClassTabbarButtonsIdentifierLocations;
    self.forumsButton.tag = CCClassTabbarButtonsIdentifierForums;
    for (UIButton *button in self.buttons){
        [self configButton:button];
    }
    [self didSelectButton:self.classmatesButton];
}

- (void)configButton:(UIButton *)button
{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"tab_bar_button_background"] forState:UIControlStateSelected];
    [button setImage:[button imageForState:UIControlStateSelected] forState:UIControlStateSelected | UIControlStateHighlighted];
    [button setBackgroundImage:[button backgroundImageForState:UIControlStateSelected] forState:UIControlStateSelected | UIControlStateHighlighted];
}

- (IBAction)didSelectButton:(UIButton *)sender
{
    if (self.currentlySelected != sender){
        [self.delegate didSelectBarItemWithIdentifier:sender.tag];
        self.currentlySelected = sender;
        for(UIButton *button in self.buttons){
            [button setSelected:NO];
        }
        [self.currentlySelected setSelected:YES];
    }
    else {
        [self.delegate didReselectBarItemWithIdentifier:sender.tag];
    }
}

- (NSInteger)selectedButtonIdentifier
{
    return self.currentlySelected.tag;
}

@end
