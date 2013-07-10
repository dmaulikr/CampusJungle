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

@interface CCPrivateMessageController ()

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UITextView *inputField;
@property (nonatomic, strong) id <CCMessageAPIProviderProtocol> ioc_messageAPIProvider;

- (IBAction)sendButtonDidPress;

@end

@implementation CCPrivateMessageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundImage.image = [[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.tapRecognizer.enabled = YES;
}

- (IBAction)sendButtonDidPress
{
    if(self.inputField.text.length){
        [self.ioc_messageAPIProvider sendMessage:self.inputField.text
                                          toUser:self.recipient.uid
                                  successHandler:^(id result) {
                                      [self.successMessageSendTransaction perform];
                                                                }
                                    errorHandler:^(NSError *error) {
                            [CCStandardErrorHandler showErrorWithError:error];
                                                                        }];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Message can not be empty"];
    }
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [self sendButtonDidPress];
    return NO;
}

@end
