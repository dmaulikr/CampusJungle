//
//  CCVoteScreenController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCVoteScreenController.h"
#import "GSRadioButtonSetController.h"
#import "CCVotesAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCButtonsHelper.h"

@interface CCVoteScreenController ()<GSRadioButtonSetControllerDelegate>

@property (nonatomic, strong) GSRadioButtonSetController * engagementRadioButtonSetController;
@property (nonatomic, weak) IBOutlet UIButton *engagementPourButton;
@property (nonatomic, weak) IBOutlet UIButton *engagementFairButton;
@property (nonatomic, weak) IBOutlet UIButton *engagementCoolButton;
@property (nonatomic, weak) IBOutlet UIButton *engagementCoolestButton;

@property (nonatomic, strong) GSRadioButtonSetController * intrestingRadioButtonSetController;
@property (nonatomic, weak) IBOutlet UIButton *intrestingPourButton;
@property (nonatomic, weak) IBOutlet UIButton *intrestingFairButton;
@property (nonatomic, weak) IBOutlet UIButton *intrestingCoolButton;
@property (nonatomic, weak) IBOutlet UIButton *intrestingCoolestButton;

@property (nonatomic, strong) GSRadioButtonSetController * handoutsRadioButtonSetController;
@property (nonatomic, weak) IBOutlet UIButton *handoutsPourButton;
@property (nonatomic, weak) IBOutlet UIButton *handoutsFairButton;
@property (nonatomic, weak) IBOutlet UIButton *handoutsCoolButton;
@property (nonatomic, weak) IBOutlet UIButton *handoutsCoolestButton;

@property (nonatomic, strong) GSRadioButtonSetController * speedRadioButtonSetController;
@property (nonatomic, weak) IBOutlet UIButton *speedTooSlowButton;
@property (nonatomic, weak) IBOutlet UIButton *speedSlowButton;
@property (nonatomic, weak) IBOutlet UIButton *speedPerfectButton;
@property (nonatomic, weak) IBOutlet UIButton *speedFastButton;
@property (nonatomic, weak) IBOutlet UIButton *speedTooFastButton;

@property (nonatomic, weak) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) id <CCVotesAPIProviderProtocol> ioc_apiProvider;

- (IBAction)submitButtonDidPressed;

@end

@implementation CCVoteScreenController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Feedback";
    [self setupRadioButtons];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    
    [[self navigationItem] setBackBarButtonItem: newBackButton];
}

- (void)setupRadioButtons
{
    self.engagementRadioButtonSetController = [[GSRadioButtonSetController alloc] init];
    self.speedRadioButtonSetController = [[GSRadioButtonSetController alloc] init];
    self.handoutsRadioButtonSetController = [[GSRadioButtonSetController alloc] init];
    self.speedRadioButtonSetController = [[GSRadioButtonSetController alloc] init];
    self.speedRadioButtonSetController.delegate = self;
    self.engagementRadioButtonSetController.delegate = self;
    self.handoutsRadioButtonSetController = [[GSRadioButtonSetController alloc] init];
    self.handoutsRadioButtonSetController.delegate = self;
    
    self.intrestingRadioButtonSetController = [[GSRadioButtonSetController alloc] init];
    self.intrestingRadioButtonSetController.delegate = self;
    
    self.engagementRadioButtonSetController.buttons = @[self.engagementPourButton,
                                                        self.engagementFairButton,
                                                        self.engagementCoolButton,
                                                        self.engagementCoolestButton];
    
    self.intrestingRadioButtonSetController.buttons = @[self.intrestingPourButton,
                                                        self.intrestingFairButton,
                                                        self.intrestingCoolButton,
                                                        self.intrestingCoolestButton];
    
    self.handoutsRadioButtonSetController.buttons = @[self.handoutsPourButton,
                                                      self.handoutsFairButton,
                                                      self.handoutsCoolButton,
                                                      self.handoutsCoolestButton];
    
    self.speedRadioButtonSetController.buttons = @[self.speedTooSlowButton,
                                                   self.speedSlowButton,
                                                   self.speedPerfectButton,
                                                   self.speedFastButton,
                                                   self.speedTooFastButton];
    self.submitButton.enabled = NO;
    
    [self setbuttonsClear:self.engagementRadioButtonSetController.buttons];
    [self setbuttonsClear:self.intrestingRadioButtonSetController.buttons];
    [self setbuttonsClear:self.handoutsRadioButtonSetController.buttons];
    [self setbuttonsClear:self.speedRadioButtonSetController.buttons];

}

- (void)setbuttonsClear:(NSArray *)array
{
    for(UIButton *button in array){
        [button setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"check_active"] forState:UIControlStateSelected];
    }

}

- (void)radioButtonSetController:(GSRadioButtonSetController *)controller
          didSelectButtonAtIndex:(NSUInteger)selectedIndex
{
    if([self isRearyToSubmit]){
        [self setRightNavigationItemWithTitle:@"Done" selector:@selector(submitButtonDidPressed)];
    }
}

- (BOOL)isRearyToSubmit
{
    if(self.engagementRadioButtonSetController.selectedIndex == NSNotFound){
        return NO;
    }
    if(self.intrestingRadioButtonSetController.selectedIndex == NSNotFound){
        return NO;
    }
    if(self.handoutsRadioButtonSetController.selectedIndex == NSNotFound){
        return NO;
    }
    if(self.speedRadioButtonSetController.selectedIndex == NSNotFound){
        return NO;
    }
    return YES;
}

- (NSNumber *)valueForController:(GSRadioButtonSetController *)radioButtonSetController
{
    return @((float)radioButtonSetController.selectedIndex/(radioButtonSetController.buttons.count - 1));
    
}

- (void)submitButtonDidPressed
{
    NSDictionary *params = @{
                             @"ranks" : @[
                                     @{
                                         @"question_code" : @(1),
                                         @"value" : [self valueForController:self.engagementRadioButtonSetController],
                                         },
                                     @{
                                         @"question_code" : @(2),
                                         @"value" : [self valueForController:self.intrestingRadioButtonSetController],
                                         },
                                     @{
                                         @"question_code" : @(3),
                                         @"value" : [self valueForController:self.handoutsRadioButtonSetController],
                                         },
                                     @{
                                         @"question_code" : @(4),
                                         @"value" : [self valueForController:self.speedRadioButtonSetController],
                                         },
                                     ]
                             };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   [self.ioc_apiProvider postFeedback:params
                              classID:self.currentClass.classID successHandler:^(id result) {
                                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                  [self.voteResultTransaction performWithObject:self.currentClass];
                              } errorHandler:^(NSError *error) {
                                  [CCStandardErrorHandler showErrorWithError:error];
                                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                              }];
}

@end
