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

#define minimalTextLenght 3

@interface CCReviewController ()<UITextViewDelegate>

@property (nonatomic, strong) DYRateView *rateView;
@property (nonatomic, weak) IBOutlet UIImageView *textFieldBackground;
@property (nonatomic, weak) IBOutlet UITextView *textFiled;
@property (nonatomic, weak) IBOutlet UIView *rateViewContainer;
@property (nonatomic, strong) id <CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, weak) IBOutlet UIButton *submitButton;

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

}

- (void)configStars
{
    self.rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, 0, 320, 100) fullStar:[self scaledImageWithName:@"star_icon_active"] emptyStar:[self scaledImageWithName:@"star_icon"]];
    self.rateView.rate = 5;
    [self.rateViewContainer addSubview:self.rateView];
    self.rateView.editable = YES;
    self.rateView.alignment = RateViewAlignmentCenter;
}

- (UIImage *)scaledImageWithName:(NSString *)name
{
    UIImage *originalImage = [UIImage imageNamed:name];
    UIImage *scaledImage =
    [UIImage imageWithCGImage:[originalImage CGImage]
                        scale:(originalImage.scale * 1.5)
                  orientation:(originalImage.imageOrientation)];
    return scaledImage;
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
    [self.view endEditing:YES];
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length >= minimalTextLenght){
        self.submitButton.enabled = YES;
    } else {
        self.submitButton.enabled = NO;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length >= minimalTextLenght){
        self.submitButton.enabled = YES;
    } else {
        self.submitButton.enabled = NO;
    }
}

@end
