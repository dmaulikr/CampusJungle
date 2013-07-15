//
//  CCRateControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReviewController.h"
#import "DYRateView.h"
#import "CCStandardErrorHandler.h"
#import "CCAPIProviderProtocol.h"


@interface CCReviewController ()

@property (nonatomic, strong) DYRateView *rateView;
@property (nonatomic, weak) IBOutlet UIImageView *textFieldBackground;
@property (nonatomic, weak) IBOutlet UITextView *textFiled;
@property (nonatomic, weak) IBOutlet UIView *rateViewContainer;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;

- (IBAction)rate;

@end

@implementation CCReviewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configStars];
    self.textFieldBackground.image = [[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.tapRecognizer.enabled = YES;
    self.title = @"Review";
    [(TPKeyboardAvoidingTableView *)self.view setScrollEnabled:NO];
}

- (void)configStars
{
    self.rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, 0, 320, 100) fullStar:[UIImage imageNamed:@"StarFullLarge"] emptyStar:[UIImage imageNamed:@"StarEmptyLarge"]];
    self.rateView.rate = 5;
    [self.rateViewContainer addSubview:self.rateView];
    self.rateView.editable = YES;
    self.rateView.alignment = RateViewAlignmentCenter;
}

- (IBAction)rate
{
    if(self.textFiled.text.length){
        [self.ioc_apiProvider postReviewWithRate:@(self.rateView.rate)
                                            text:self.textFiled.text
                                   forUserWithID:self.note.ownerID
                                  successHandler:^(RKMappingResult *result) {
                                      [self.backToNoteTransaction perform];
                                  }
                                    errorHandler:^(NSError *error) {
                                        [CCStandardErrorHandler showErrorWithError:error];
                                    }];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Review can not be without comment"];
    }
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [self rate];
    return NO;
}

@end
