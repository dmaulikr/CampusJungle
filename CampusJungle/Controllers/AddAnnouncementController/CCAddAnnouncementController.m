//
//  CCAddAnnouncementController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddAnnouncementController.h"
#import "CCStandardErrorHandler.h"
#import "CCAnnouncementAPIProviderProtocol.h"

@interface CCAddAnnouncementController ()

@property (nonatomic, weak) IBOutlet UITextView *messageTextView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextField *topicTextField;
@property (nonatomic, strong) id <CCAnnouncementAPIProviderProtocol> ioc_announcementAPIProvider;

@end

@implementation CCAddAnnouncementController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRightNavigationItemWithTitle:@"Add" selector:@selector(addButtonDidPressed)];
    self.tapRecognizer.enabled = YES;
    self.title = @"New Announcement";
    [self setupImageViews];
}

- (void)addButtonDidPressed
{
    if([self vaildateFileds]){
        CCAnnouncement *announcement = [CCAnnouncement new];
        announcement.classID = self.currentClass.classID;
        announcement.topic = self.topicTextField.text;
        announcement.message = self.messageTextView.text;
        [self.ioc_announcementAPIProvider postAnnouncement:announcement successHandler:^(RKMappingResult *result) {
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.createAnnouncement duration:CCProgressHudsConstants.loaderDuration];
            [self.backToListTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }
}

- (BOOL)vaildateFileds
{
    if (![self.topicTextField.text length]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyTopic];
        return NO;
    }
    if (![self.messageTextView.text length]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyMessageText];
        return NO;
    }
    return YES;
}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
    return YES;
}

@end
