//
//  CCGroupTabbarViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupTabbarViewController.h"

@interface CCGroupTabbarViewController ()

@property (nonatomic, weak) IBOutlet UIButton *groupmatesButton;
@property (nonatomic, weak) IBOutlet UIButton *locationButton;
@property (nonatomic, weak) IBOutlet UIButton *questionsButton;
@property (nonatomic, weak) IBOutlet UIButton *messagesButton;

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, weak) UIButton *currentlySelected;

@end

@implementation CCGroupTabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttons = @[self.groupmatesButton, self.locationButton, self.questionsButton];
    self.groupmatesButton.tag = CCClassTabbarButtonsIdentifierClassmate;
    self.locationButton.tag = CCClassTabbarButtonsIdentifierLocations;
    self.questionsButton.tag = CCClassTabbarButtonsIdentifierQuestions;
    self.messagesButton.tag = CCClassTabbarButtonsIdentifierGroup;
    for (UIButton *button in self.buttons){
        [self configButton:button];
    }
    [self didSelectButton:self.groupmatesButton];
}

- (void)configButton:(UIButton *)button
{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"tab_bar_button_background"] forState:UIControlStateSelected];
    [button setImage:[button imageForState:UIControlStateSelected] forState:UIControlStateSelected | UIControlStateHighlighted];
    [button setBackgroundImage:[button backgroundImageForState:UIControlStateSelected] forState:UIControlStateSelected | UIControlStateHighlighted];
}

#pragma mark -
#pragma mark Actions
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
