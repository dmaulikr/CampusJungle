//
//  CCMessageDetailsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessageDetailsController.h"
#import "CCStuffAPIProviderProtocol.h"
#import "CCUserSessionProtocol.h"
#import "CCAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCButtonsHelper.h"

#import "CCUser.h"

@interface CCMessageDetailsController ()

@property (nonatomic, weak) IBOutlet UITextView *messageText;
@property (nonatomic, weak) IBOutlet UIImageView *senderAvatar;
@property (nonatomic, weak) IBOutlet UIImageView *messageBackgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *senderName;
@property (nonatomic, weak) IBOutlet UIButton *senderDetailsButton;
@property (nonatomic, weak) IBOutlet UIButton *replyButton;

@property (nonatomic ,strong) id<CCAPIProviderProtocol> ioc_APIProvider;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) CCUser *sender;

@end

@implementation CCMessageDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Message";
    [self loadMessageInfo];
    [self loadInfo];
    [self setupImageViews];
    [self setupButtons];
}

- (void)setupButtons
{
    [CCButtonsHelper removeBackgroundImageInButton:self.senderDetailsButton];
    if ([self.ioc_userSessionProvider.currentUser.uid isEqualToString:self.message.senderID]) {
        [self.replyButton setHidden:YES];
        [self.senderDetailsButton setHidden:YES];
    }
}

- (void)setupImageViews
{
    [self.messageBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

- (void)loadInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_APIProvider getUserWithID:self.message.senderID
                         successHandler:^(RKMappingResult *result) {
                             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                             self.sender = result.firstObject;
                         } errorHandler:^(NSError *error) {
                             [CCStandardErrorHandler showErrorWithError:error];
                         }];
}

- (void)setSender:(CCUser *)sender
{
    _sender = sender;
    [self loadSenderInfo];
}

- (void)loadMessageInfo
{
    self.messageText.text = self.message.text;
}

- (void)loadSenderInfo
{
    NSURL *avatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.sender.avatar]];
    [self.senderAvatar setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    self.senderName.text = [NSString stringWithFormat:@"%@ %@",self.sender.firstName, self.sender.lastName];
}

- (IBAction)senderButtonDidPressed
{
    [self.senderDetailsTransaction performWithObject:self.sender];
}

- (IBAction)answerButtonDidPressed
{
    [self.replyTransaction performWithObject:self.sender];
}

@end
