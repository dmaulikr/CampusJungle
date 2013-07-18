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

#pragma mark -
#pragma mark Requests
- (void)addAnswer:(CCAnswer *)answer
{
    __weak CCAddAnswerViewController *weakSelf = self;
    [self.ioc_answerApiProvider postAnswer:answer successHandler:^(RKMappingResult *object) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadAnswers object:nil];
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.addedAnswer duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
