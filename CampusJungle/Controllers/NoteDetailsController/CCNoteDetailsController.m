//
//  CCNoteDetailsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteDetailsController.h"
#import "CCNotesAPIProviderProtolcol.h"
#import "CCMarketAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "UIAlertView+BlocksKit.h"
#import "CCUserSessionProtocol.h"
#import "CCUser.h"
#import "GIAlert.h"
#import "CCReviewsDataProvider.h"
#import "CCReviewCell.h"
#import "CCAlertHelper.h"

@interface CCNoteDetailsController ()

@property (nonatomic, weak) IBOutlet UILabel *noteName;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;

@property (nonatomic, weak) IBOutlet UIButton *fullAccessButton;
@property (nonatomic, weak) IBOutlet UIButton *viewOnlyAccessButton;
@property (nonatomic, weak) IBOutlet UIButton *pdfButton;

@property (nonatomic, weak) IBOutlet UIButton *resendLinkButton;
@property (nonatomic, weak) IBOutlet UIButton *removeNoteButton;
@property (nonatomic, strong) CCReviewsDataProvider *reviewsDataProvider;

@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;
@property (nonatomic, strong) id <CCMarketAPIProviderProtocol> ioc_marketAPIProvider;

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

- (IBAction)rateButtonPressed;

@end

@implementation CCNoteDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNotesInfo];
    self.title = @"Note";
    self.reviewsDataProvider = [CCReviewsDataProvider new];
    self.reviewsDataProvider.userID = self.note.ownerID;
    [self configTableWithProvider:self.reviewsDataProvider cellClass:[CCReviewCell class]];
}

- (void)setUpNotesInfo
{
    self.noteName.text = self.note.noteDescription;
    if(self.note.thumbnailRetina.length){
        NSURL *urlToThumbnail = [NSURL URLWithString:[CCAPIDefines.baseURL stringByAppendingString:self.note.thumbnailRetina]];
        [self.thumbnail setImageWithURL:urlToThumbnail];
    }
    if(self.note.fullAccess){
        [self.viewOnlyAccessButton setHidden:YES];
        [self.pdfButton setHidden:NO];
        [self.resendLinkButton setHidden:YES];
        if([self.note.fullAccess isEqualToString:@"true"]){
            [self.fullAccessButton setHidden:YES];
            [self.resendLinkButton setHidden:NO];
        }
    } else {
        [self.pdfButton setHidden:YES];
        [self.resendLinkButton setHidden:YES];
    }
    
    if (![self.note.ownerID isEqualToString:self.ioc_userSession.currentUser.uid]){
        [self.removeNoteButton setHidden:YES];
    }

    NSString *viewOnlyTitle = [NSString stringWithFormat:@"Buy for view:%@",self.note.price];

    [self.viewOnlyAccessButton setTitle:viewOnlyTitle forState:UIControlStateNormal];

    NSNumber *fullPrice = self.note.fullPrice;
    
    if(self.note.fullAccess){
        fullPrice = @(fullPrice.integerValue - self.note.price.integerValue);
    }
    
    NSString *fullAccessTitle = [NSString stringWithFormat:@"Buy for download:%@",fullPrice];
    [self.fullAccessButton setTitle:fullAccessTitle forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark Actions
- (IBAction)viewPDFButtonDidPressed
{
    [self.ioc_notesAPIProvider fetchAttachmentURLForNoteWithID:self.note.noteID successHandler:^(id result){
        NSString *link = result[@"link"];
            if(link.length){
                self.note.link = link;
                [self.viewNotesAsPDFTransaction performWithObject:self.note.link];
            } else {
                [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCAlertsMessages.noteNotReadyForView];
            }
    } errorHandler:^(NSError *error){
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (IBAction)buyForViewButtonPressed
{
    [self showConfirmWithSuccess:^{
        [self.ioc_marketAPIProvider performPurchase:self.note.noteID fullAccess:NO successHandler:^(RKMappingResult *result) {
            self.note.fullAccess = @"false";
            [self setUpNotesInfo];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

- (IBAction)buyForDownloadButtonPressed
{
    if([[self.ioc_userSession currentUser] email]){
        [self showConfirmWithSuccess:^{
            [self.ioc_marketAPIProvider performPurchase:self.note.noteID fullAccess:YES     successHandler:^(RKMappingResult *result) {
                self.note.fullAccess = @"true";
                [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.success
                                                   message:CCAlertsMessages.checkYourMail];
                [self setUpNotesInfo];
            } errorHandler:^(NSError *error) {
                [CCStandardErrorHandler showErrorWithError:error];
            }];
        }];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error
                                           message: CCAlertsMessages.setEmailFirst];
    }
}

- (void)showConfirmWithSuccess:(successHandler)success
{    
    GIAlertButton *noButton = [GIAlertButton cancelButtonWithTitle:CCAlertsButtons.noButton action:nil];
    GIAlertButton *yesButton = [GIAlertButton buttonWithTitle:CCAlertsButtons.yesButton action:success];
    
    GIAlert *alert = [GIAlert alertWithTitle:CCAlertsMessages.confirmation
                                     message:CCAlertsMessages.confirmationMessage
                                     buttons:@[noButton, yesButton,]];
    [alert show];
}

- (IBAction)removeNoteButtonDidPressed
{
    __weak CCNoteDetailsController *weakSelf = self;
    [CCAlertHelper showWithMessage:CCAlertsMessages.deleteNote success:^{
        [weakSelf.ioc_notesAPIProvider removeNoteWithID:self.note.noteID successHandler:^(id result) {
            [weakSelf.backToListTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

- (IBAction)resendLinkButtonDidPressed
{
    [self.ioc_notesAPIProvider resendLinkToNote:self.note.noteID successHandler:^(id result) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.success
                                           message:CCAlertsMessages.checkYourMail];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (IBAction)rateButtonPressed
{
    [self.rateTransaction performWithObject:self.note];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.reviewsDataProvider loadItems];
}

@end
