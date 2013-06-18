//
//  CCNoteDetailsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteDetailsController.h"
#import "CCDefines.h"
#import "CCNotesAPIProviderProtolcol.h"
#import "CCMarketAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "UIAlertView+BlocksKit.h"
#import "CCAlertDefines.h"
#import "CCUserSessionProtocol.h"
#import "CCUser.h"

@interface CCNoteDetailsController ()

@property (nonatomic, weak) IBOutlet UILabel *noteName;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;

@property (nonatomic, weak) IBOutlet UIButton *fullAccessButton;
@property (nonatomic, weak) IBOutlet UIButton *viewOnlyAccessButton;
@property (nonatomic, weak) IBOutlet UIButton *pdfButton;

@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;
@property (nonatomic, strong) id <CCMarketAPIProviderProtocol> ioc_marketAPIProvider;

@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCNoteDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNotesInfo];
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
        if([self.note.fullAccess isEqualToString:@"true"]){
            [self.fullAccessButton setHidden:YES];
        }
    } else {
        [self.pdfButton setHidden:YES];
    }

    NSString *viewOnlyTitle = [NSString stringWithFormat:@"Buy for view:%@",self.note.price];

    [self.viewOnlyAccessButton setTitle:viewOnlyTitle forState:UIControlStateNormal];

    NSString *fullAccessTitle = [NSString stringWithFormat:@"Buy for download:%@",self.note.fullPrice];
    [self.fullAccessButton setTitle:fullAccessTitle forState:UIControlStateNormal];
}

- (IBAction)viewPDFButtonDidPressed
{
    [self.ioc_notesAPIProvider fetchAttachmentURLForNoteWithID:self.note.noteID successHandler:^(id result){
        self.note.link = result[@"link"];
        [self.viewNotesAsPDFTransaction performWithObject:self.note];
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
	UIAlertView *confirmAlert = [UIAlertView alertViewWithTitle:CCAlertsMessages.confirmation message:CCAlertsMessages.confirmationMessage];
	[confirmAlert addButtonWithTitle:CCAlertsButtons.yesButton handler:success];
	[confirmAlert addButtonWithTitle:CCAlertsButtons.noButton];
	[confirmAlert show];
}

@end
