//
//  CCOfferControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOfferControllerViewController.h"
#import "CCStandardErrorHandler.h"
#import "CCStuffAPIProviderProtocol.h"

@interface CCOfferControllerViewController ()<UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;

@property (nonatomic, weak) id <CCStuffAPIProviderProtocol> ioc_stuffAPIProvider;

- (IBAction)sendButtonDidPress;

@end

@implementation CCOfferControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundImage.image = [[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.tapRecognizer.enabled = YES;
    self.title = @"Offer";
}

- (IBAction)sendButtonDidPress
{
    if(self.inputField.text.length){
        [self sendOffer];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Offer can not be empty"];
    }
}

- (void)sendOffer
{
    [self.ioc_stuffAPIProvider makeAnOffer:self.inputField.text
                             toStuffWithID:self.currentStuff.stuffID
                            successHandler:^(id result) {
                                [self.backToStuffTransaction perform];
                            } errorHandler:^(NSError *error) {
                                [CCStandardErrorHandler showErrorWithError:error];
                            }];
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [self sendButtonDidPress];
    return NO;
}

@end
