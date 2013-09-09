//
//  CCAddAnswerViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddAnswerViewController.h"
#import "CCQuestion.h"
#import "CCAnswer.h"
#import "CCQuestionHeaderView.h"
#import "CCStringHelper.h"
#import "CCViewPositioningHelper.h"
#import "CCStandardErrorHandler.h"

#import "CCAnswersApiProviderProtocol.h"

@interface CCAddAnswerViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *questionHeaderView;
@property (nonatomic, weak) IBOutlet UIView *addAnswerView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextView *answerTextView;
@property (nonatomic, weak) IBOutlet UIScrollView *keyboardAvoidScrollView;

@property (nonatomic, strong) CCQuestion *question;
@property (nonatomic, strong) id<CCAnswersApiProviderProtocol> ioc_answerApiProvider;

@property (nonatomic, strong) NSString *pdfURL;
@property (nonatomic, strong) NSArray *arrayOfURLs;
@property (nonatomic, strong) NSArray *arrayOfImages;

@property (nonatomic, weak) IBOutlet UIButton *imageDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *pdfDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *imageButton;

@end

@implementation CCAddAnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupHeaderView];
    [self fixLayout];
    [self setupImageViews];

    [self setTitle:@"Add Answer"];
    [self setRightNavigationItemWithTitle:@"Add" selector:@selector(addAnswerButtonDidPressed:)];
}

- (void)setupHeaderView
{
    CCQuestionHeaderView *headerView = [[CCQuestionHeaderView alloc] initWithQuestionText:self.question.text bottomDividerVisibile:NO];
    [self.questionHeaderView setBounds:headerView.bounds];
    [self.questionHeaderView addSubview:headerView];
    [CCViewPositioningHelper setOriginY:0 toView:self.questionHeaderView];
}

- (void)fixLayout
{
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.questionHeaderView] toView:self.addAnswerView];
    [CCViewPositioningHelper setHeight:[CCViewPositioningHelper bottomOfView:self.addAnswerView] toView:self.keyboardAvoidScrollView];
}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

#pragma mark -
#pragma mark Actions
- (void)addAnswerButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        CCAnswer *answer = [CCAnswer answerWithText:self.answerTextView.text];
        answer.questionId = self.question.questionId;
        answer.arrayOfImages = self.arrayOfImages;
        answer.arrayOfImageUrls = self.arrayOfURLs;
        answer.pdfUrl = self.pdfURL;
        [self addAnswer:answer];
    }
}

#pragma mark -
#pragma mark Validation
- (BOOL)validateInputData
{
    if ([self.answerTextView.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyAnswerText];
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

- (IBAction)uploadPhotosButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
            self.arrayOfImages = arrayOfImages;
            [self.backToSelfController perform];
            [self unableUploadButtons];
        }];
    }
}

- (IBAction)uploadImagesFromDropboxButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            self.arrayOfURLs = arrayOfUrls;
            [self.backToSelfController perform];
            [self unableUploadButtons];
        }];
    }
}

- (IBAction)uploadPdfFromDropboxButtonDidPressed:(id)sender
{
    if([self validateInputData]){
        [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            self.pdfURL = arrayOfUrls.lastObject;
            [self.backToSelfController perform];
            [self unableUploadButtons];
        }];
    }
}

- (void)unableUploadButtons
{
    self.imageButton.enabled = NO;
    self.imageDropboxButton.enabled = NO;
    self.pdfDropboxButton.enabled = NO;
}

#pragma mark -
#pragma mark Requests
- (void)addAnswer:(CCAnswer *)answer
{
    if(!answer.arrayOfImages){
        __weak CCAddAnswerViewController *weakSelf = self;
        [self.ioc_answerApiProvider postAnswer:answer successHandler:^(RKMappingResult *object) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadAnswers object:nil];
            [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.addedAnswer duration:CCProgressHudsConstants.loaderDuration];
            [weakSelf.backTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    } else {
        [self uploadAnswerWithImages:answer];
    }
}

- (void)uploadAnswerWithImages:(CCAnswer *)answer
{
    __weak CCAddAnswerViewController *weakSelf = self;
    [self.ioc_answerApiProvider postUploadInfoWithImages:answer
                                                withImages:self.arrayOfImages successHandler:^(id result) {
                                                    
                                                } errorHandler:^(NSError *error) {
                                                    [CCStandardErrorHandler showErrorWithError:error];
                                                } progress:^(double finished) {
                                                    [weakSelf.backTransaction perform];
                                                    weakSelf.backTransaction = nil;
                                                }];

}

@end
