//
//  CCPrivateMessageControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPrivateMessageController.h"
#import "CCStandardErrorHandler.h"
#import "CCMessageAPIProviderProtocol.h"
#import "CCStringHelper.h"

@interface CCPrivateMessageController ()

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UITextView *inputField;
@property (nonatomic, strong) id <CCMessageAPIProviderProtocol> ioc_messageAPIProvider;

@end

@implementation CCPrivateMessageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundImage.image = [[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.tapRecognizer.enabled = YES;
    self.title = @"Private Message";
    [self setRightNavigationItemWithTitle:@"Send" selector:@selector(sendButtonDidPressed:)];
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

- (void)sendButtonDidPressed:(id)sender
{
    if (self.inputField.text.length > 0){
        [self.ioc_messageAPIProvider sendMessage:self.inputField.text
                                          toUser:self.recipient.uid
                                  successHandler:^(id result) {
                                      [self.successMessageSendTransaction perform];
                                                                }
                                    errorHandler:^(NSError *error) {
                            [CCStandardErrorHandler showErrorWithError:error];
                                                                        }];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyMessageText];
    }
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    [textView resignFirstResponder];
    return NO;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [CCStringHelper trimSpacesFromString:textView.text];
}

@end
