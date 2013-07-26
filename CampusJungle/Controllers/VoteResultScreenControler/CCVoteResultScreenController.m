//
//  CCVoteResultScreenController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCVoteResultScreenController.h"
#import "CCUIImageHelper.h"
#import "CCVotesAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCFeedback.h"
#import "CCScaleView.h"

@interface CCVoteResultScreenController ()

@property (nonatomic, strong) id <CCVotesAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, strong) CCFeedback *feedback;

@property (nonatomic, strong) IBOutlet UIButton *recalculateButton;

@property (nonatomic, weak) IBOutlet CCScaleView *currentEngagementScale;
@property (nonatomic, weak) IBOutlet CCScaleView *currentIntrestingScale;
@property (nonatomic, weak) IBOutlet CCScaleView *currentHandoutsScale;
@property (nonatomic, weak) IBOutlet CCScaleView *currentSpeedScale;

@property (nonatomic, weak) IBOutlet CCScaleView *totalEngagementScale;
@property (nonatomic, weak) IBOutlet CCScaleView *totalIntrestingScale;
@property (nonatomic, weak) IBOutlet CCScaleView *totalHandoutsScale;
@property (nonatomic, weak) IBOutlet CCScaleView *totalSpeedScale;

- (IBAction)didPressRecalculateButton;

@end

@implementation CCVoteResultScreenController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Vote Results";
    
    NSArray *scaleArray = @[@"Pour",@"Fair",@"Cool",@"Coolest"];
    NSArray *speedArray = @[@"  Too slow",@"Slow",@"Perfect",@"Fast",@"Too fast  "];
    self.currentEngagementScale.value = 0.5;
    self.currentEngagementScale.arrayOfValues = scaleArray;
    self.currentHandoutsScale.arrayOfValues = scaleArray;
    self.currentIntrestingScale.arrayOfValues = scaleArray;
    self.currentSpeedScale.arrayOfValues = speedArray;
    
    self.totalEngagementScale.arrayOfValues = scaleArray;
    self.totalHandoutsScale.arrayOfValues = scaleArray;
    self.totalIntrestingScale.arrayOfValues = scaleArray;
    self.totalSpeedScale.arrayOfValues = speedArray;
    
        if(![self.currentClass.isProfessor boolValue]){
        self.recalculateButton.hidden = YES;
    }
    
    [self loadData];
}

- (void)loadData
{
    [self.ioc_apiProvider loadFeedbackForClassWithID:self.currentClass.classID
                                      successHandler:^(RKMappingResult *result) {
                                          self.feedback = result.firstObject;
                                          [self setUpFeedBack];
                                      } errorHandler:^(NSError *error) {
                                          [CCStandardErrorHandler showErrorWithError:error];
                                      }];
}

- (void)setUpFeedBack
{
    self.currentEngagementScale.value = [self.feedback.current_statistics[@"question1"] floatValue];
    self.currentHandoutsScale.value = [self.feedback.current_statistics[@"question2"] floatValue];
    self.currentIntrestingScale.value = [self.feedback.current_statistics[@"question3"] floatValue];
    self.currentSpeedScale.value = [self.feedback.current_statistics[@"question4"] floatValue];
    
    self.totalEngagementScale.value = [self.feedback.total_statistics[@"question1"] floatValue];
    self.totalHandoutsScale.value = [self.feedback.total_statistics[@"question2"] floatValue];
    self.totalIntrestingScale.value = [self.feedback.total_statistics[@"question3"] floatValue];
    self.totalSpeedScale.value = [self.feedback.total_statistics[@"question4"] floatValue];
}

- (IBAction)didPressRecalculateButton
{
    [self.ioc_apiProvider recalculateFeedbackInClassWithID:self.currentClass.classID
                                            successHandler:^(RKMappingResult *result) {
                                                self.feedback = result.firstObject;
                                                [self setUpFeedBack];
                                            }
                                              errorHandler:^(NSError *error) {
                                                  [CCStandardErrorHandler showErrorWithError:error];
                                              }];
}

@end
