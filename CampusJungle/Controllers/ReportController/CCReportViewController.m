//
//  CCReportViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReportViewController.h"
#import "CCReport.h"

#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCReportsApiProviderProtocol.h"

@interface CCReportViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *textBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextView *reportTextView;

@property (nonatomic, strong) CCReport *report;
@property (nonatomic, strong) id<CCReportsApiProviderProtocol> ioc_reportsApiProvider;

@end

@implementation CCReportViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupImageView];
    [self setRightNavigationItemWithTitle:@"Send" selector:@selector(sendButtonDidPressed:)];
    [self setTitle:@"Send Report"];
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

- (void)setupImageView
{
    self.textBackgroundImageView.image = [[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

#pragma mark -
#pragma mark Actions
- (void)sendButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        self.report.text = self.reportTextView.text;
        [self sendReport:self.report];
    }
}

#pragma mark -
#pragma mark Data Validation
- (BOOL)validateInputData
{
    if ([self.reportTextView.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyReportText];
        return NO;
    }
    return YES;
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

#pragma mark -
#pragma mark Requests
- (void)sendReport:(CCReport *)report
{
    __weak CCReportViewController *weakSelf = self;
    [self.ioc_reportsApiProvider postReport:report successHandler:^(id result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.sentReport duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
