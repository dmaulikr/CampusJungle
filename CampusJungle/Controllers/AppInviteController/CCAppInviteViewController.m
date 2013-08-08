//
//  CCAppInviteViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppInviteViewController.h"
#import "CCClass.h"

#import "CCAppInviteDataProvider.h"
#import "CCAppInviteDataSource.h"
#import "CCFacebookRequestParseHelper.h"

#import "CCAddressBookRecordCell.h"
#import "CCAppearanceConfigurator.h"
#import "CCStandardErrorHandler.h"

#import "CCMailComposerDelegate.h"
#import "CCMessageComposerDelegate.h"

#import "CCAppInviteApiProviderProtocol.h"
#import "CCFaceBookAPIProtocol.h"
#import "CCAppInvite.h"
#import "CCAppearanceConfigurator.h"

typedef enum {
    kEmailMode = 0,
    kSMSMode = 1,
    kFacebookMode = 2,
    kTwitterMode = 3,
} InviteMode;

@interface CCAppInviteViewController ()

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) CCAppInviteDataProvider *dataProvider;
@property (nonatomic, strong) CCClass *classObject;

@property (nonatomic, strong) CCMailComposerDelegate *mailComposerDelegate;
@property (nonatomic, strong) CCMessageComposerDelegate *messageComposerDelegate;

@property (nonatomic, strong) id<CCAppInviteApiProviderProtocol> ioc_appInvitesApiProvider;
@property (nonatomic, strong) id<CCFaceBookAPIProtocol> ioc_facebookApiProvider;

@end

@implementation CCAppInviteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Earn"];
    
    [self setupTableView];
    [self setRightNavigationItemWithTitle:@"Send" selector:@selector(sendButtonDidPressed:)];
    [self setEmailInviteConfiguration];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [CCAppearanceConfigurator configurateButtons];
}

- (void)setupTableView
{
    self.dataSourceClass = [CCAppInviteDataSource class];
}

- (void)setEmailInviteConfiguration
{
    if (!self.dataProvider) {
        self.dataProvider = [CCAppInviteDataProvider new];
    }
    [self.dataProvider setMode:kEmailMode];
    [self configTableWithProvider:self.dataProvider cellClass:[CCAddressBookRecordCell class] cellReuseIdentifier:NSStringFromClass([CCAddressBookRecordCell class])];
}

- (void)setSmsInviteConfiguration
{
    if (!self.dataProvider) {
        self.dataProvider = [CCAppInviteDataProvider new];
    }
    [self.dataProvider setMode:kSMSMode];
    [self configTableWithProvider:self.dataProvider cellClass:[CCAddressBookRecordCell class] cellReuseIdentifier:NSStringFromClass([CCAddressBookRecordCell class])];
}

#pragma mark -
#pragma mark Actions
- (IBAction)segmentedControlValueDidChange:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case kEmailMode: {
            [self setEmailInviteConfiguration];
            break;
        }
        case kSMSMode: {
            [self setSmsInviteConfiguration];
            break;
        }
        case kFacebookMode: {
            [self.segmentedControl setSelectedSegmentIndex:self.dataProvider.mode];
            [self sendFacebookRequest];
            break;
        }
        case kTwitterMode: {
            [self.segmentedControl setSelectedSegmentIndex:self.dataProvider.mode];
            [self sendTwitterInvites];
            break;
        }
        default:
            break;
    }
}

- (void)sendFacebookRequest
{
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     CCAppInvitesFacebookConstants.name, @"name",
     CCAppInvitesFacebookConstants.caption, @"caption",
     CCAppInvitesFacebookConstants.description, @"description",
     CCAppInvitesFacebookConstants.link, @"link",
     [NSString stringWithFormat:@"%@/media/app_icon.png", CCAPIDefines.baseURL], @"picture",
     nil];

    [CCAppearanceConfigurator setDefaultButtonsAppearance];
    [FBWebDialogs presentFeedDialogModallyWithSession:FBSession.activeSession parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
        if (error) {
             [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.sendFacebookInviteError];
        }
        else if (result != FBWebDialogResultDialogNotCompleted) {
            NSDictionary *urlParams = [CCFacebookRequestParseHelper parseURLParams:[resultURL query]];
            if ([[urlParams allKeys] count] > 0) {
                [self sendSocialInvite];
            }
        }
        [CCAppearanceConfigurator configurateButtons];
    }];
}

- (void)sendTwitterInvites
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        [CCAppearanceConfigurator setDefaultButtonsAppearance];
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        __weak SLComposeViewController *weakTweetSheet = tweetSheet;
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result){
            [weakTweetSheet dismissViewControllerAnimated:YES completion:^{
                if (result == SLComposeViewControllerResultDone) {
                    [self sendSocialInvite];
                }
            }];
        }];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (void)sendButtonDidPressed:(id)sender
{
    NSArray *checkedCredentials = [self.dataProvider checkedCredentials];
    if ([checkedCredentials count] > 0) {
        if (self.dataProvider.mode == kEmailMode && [self canSendEmail]) {
            [self sendEmailToCredentials:checkedCredentials];
        }
        else if (self.dataProvider.mode == kSMSMode && [self canSendSms]) {
            [self sendSmsToCredentials:checkedCredentials];
        }
    }
    else {
        [SVProgressHUD showErrorWithStatus:CCValidationMessages.noUsersSelected duration:CCProgressHudsConstants.loaderDuration];
    }
}

- (void)sendEmailToCredentials:(NSArray *)credentials
{
    __weak CCAppInviteViewController *weakSelf = self;
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    
    void(^completionBlock)(void) = ^{
        [CCAppearanceConfigurator configurateTextFields];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    self.mailComposerDelegate = [[CCMailComposerDelegate alloc] initWithSuccessBlock:^{
        completionBlock();
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.appInviteSent duration:CCProgressHudsConstants.loaderDuration];
    } errorBlock:^{
        completionBlock();
    } cancelBlock:^{
        completionBlock();
    }];
    [mailViewController setMailComposeDelegate:self.mailComposerDelegate];
    [mailViewController setSubject:CCAppInvitesDefines.appInviteSubject];
    
    [mailViewController setMessageBody:CCAppInvitesDefines.emailInviteBody isHTML:NO];
    [mailViewController setToRecipients:credentials];
    
    [CCAppearanceConfigurator setDefaultTextFieldsAppearance];
    [self presentViewController:mailViewController animated:YES completion:nil];
}

- (void)sendSmsToCredentials:(NSArray *)credentials
{
    __weak CCAppInviteViewController *weakSelf = self;
    void(^completionBlock)(void) = ^{
        [CCAppearanceConfigurator configurateTextFields];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };

    MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc] init];
    self.messageComposerDelegate = [[CCMessageComposerDelegate alloc] initWithSuccessBlock:^{
        completionBlock();
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.appInviteSent duration:CCProgressHudsConstants.loaderDuration];
    } errorBlock:^{
        completionBlock();
    } cancelBlock:^{
        completionBlock();
    }];
    
    [messageViewController setBody:CCAppInvitesDefines.smsInviteBody];
    [messageViewController setRecipients:credentials];
    
    [CCAppearanceConfigurator setDefaultTextFieldsAppearance];
    [self presentViewController:messageViewController animated:YES completion:nil];
}

- (BOOL)checkSelectedItems
{
    return YES;
}

- (BOOL)canSendEmail
{
    if ([MFMailComposeViewController canSendMail]) {
        return YES;
    }
    [SVProgressHUD showErrorWithStatus:CCAlertsMessages.unableToSendEmail duration:CCProgressHudsConstants.loaderDuration];
    return NO;
}

- (BOOL)canSendSms
{
    if ([MFMessageComposeViewController canSendText]) {
        return YES;
    }
    [SVProgressHUD showErrorWithStatus:CCAlertsMessages.unableToSendSms duration:CCProgressHudsConstants.loaderDuration];
    return NO;
}

#pragma mark -
#pragma mark Requests
- (void)sendSocialInvite
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.postingMessage];
    [self.ioc_appInvitesApiProvider sendAppInviteWithSuccessHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.sendSocialInvite duration:CCProgressHudsConstants.loaderDuration];
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}


@end
