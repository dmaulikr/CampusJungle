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

typedef enum {
    kEmailMode = 0,
    kSMSMode = 1,
    kFacebookMode = 2,
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
        default:
            break;
    }
}

- (void)sendFacebookRequest
{
    [FBWebDialogs presentRequestsDialogModallyWithSession:FBSession.activeSession message:CCAppInvitesFacebookConstants.message title:CCAppInvitesFacebookConstants.title parameters:nil handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.sendFacebookInviteError];
         } else {
             if (result != FBWebDialogResultDialogNotCompleted) {
                 NSDictionary *urlParams = [CCFacebookRequestParseHelper parseURLParams:[resultURL query]];
                 if ([urlParams valueForKey:@"request"]) {
                     [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.sendFacebookInvite duration:CCProgressHudsConstants.loaderDuration];
                 }
             }
         }
     }];
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
        [self sendInvitesToRecords:[weakSelf.dataProvider checkedRecords]];
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
        [self sendInvitesToRecords:[weakSelf.dataProvider checkedRecords]];
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

- (void)sendFacebookInvitesToUsers:(NSArray *)users
{
    
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
- (void)sendInvitesToRecords:(NSArray *)recordsArray
{
    NSMutableArray *appInvitesArray = [NSMutableArray array];
    for (CCAddressBookRecord *record in recordsArray) {
        CCAppInvite *appInvite = [CCAppInvite createWithAddressBookRecord:record];
        [appInvitesArray addObject:appInvite];
    }
    __weak CCAppInviteViewController *weakSelf = self;
    [self.ioc_appInvitesApiProvider sendAppInvites:appInvitesArray successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.appInviteSent duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
