//
//  CCMailComposerDelegate.m
//  CampusJungle
//
//  Created by Yury Grinenko on 09.01.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "CCMailComposerDelegate.h"

@interface CCMailComposerDelegate ()

@property (nonatomic, copy) MailComposerSuccessBlock successBlock;
@property (nonatomic, copy) MailComposerErrorBlock errorBlock;
@property (nonatomic, copy) MailComposerCancelBlock cancelBlock;

@end

@implementation CCMailComposerDelegate

- (id)initWithSuccessBlock:(MailComposerSuccessBlock)successBlock errorBlock:(MailComposerErrorBlock)errorBlock cancelBlock:(MailComposerCancelBlock)cancelBlock {
    self = [super init];
    if (self) {
        self.successBlock = successBlock;
        self.errorBlock = errorBlock;
        self.cancelBlock = cancelBlock;
    }
    return self;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSaved:
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.emailDraftSaved duration:CCProgressHudsConstants.loaderDuration];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
            break;
        case MFMailComposeResultSent:
            if (self.successBlock) {
                self.successBlock();
            }
            break;
        case MFMailComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:CCAlertsMessages.emailSendingError duration:CCProgressHudsConstants.loaderDuration];
            if (self.errorBlock) {
                self.errorBlock();
            }
            break;
        case MFMailComposeResultCancelled:
            if (self.cancelBlock) {
                self.cancelBlock();
            }
            break;
        default:
            break;
    }
}

@end
