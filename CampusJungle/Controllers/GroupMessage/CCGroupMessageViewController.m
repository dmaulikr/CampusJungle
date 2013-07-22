//
//  CCGroupMessageViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupMessageViewController.h"
#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCGroup.h"
#import "CCMessage.h"
#import "CCMessageAPIProviderProtocol.h"

@interface CCGroupMessageViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UITextView *messageTextView;

@property (nonatomic, strong) CCGroup *group;
@property (nonatomic, strong) id<CCMessageAPIProviderProtocol> ioc_messagesApiProvider;

@end

@implementation CCGroupMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.backgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    [self setTitle:@"Group Message"];
    [self setRightNavigationItemWithTitle:@"Send" selector:@selector(sendButtonDidPressed:)];
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

#pragma mark -
#pragma mark Actions
- (void)sendButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        [self sendMessage:self.messageTextView.text];
    }
}

#pragma mark -
#pragma mark Input Data Validation
- (BOOL)validateInputData
{
    if ([self.messageTextView.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyMessageText];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [CCStringHelper trimSpacesFromString:textView.text];
}

#pragma mark -
#pragma mark Requests
- (void)sendMessage:(NSString *)message
{
    __weak CCGroupMessageViewController *weakSelf = self;
    [self.ioc_messagesApiProvider sendMessage:message toGroup:self.group.groupId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.sentGroupMessage duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
