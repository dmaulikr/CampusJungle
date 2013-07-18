//
//  CCAddCommentViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddCommentViewController.h"
#import "CCAnswer.h"
#import "CCComment.h"

#import "CCViewPositioningHelper.h"
#import "CCAnswerHeader.h"
#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"

#import "CCCommentsApiProviderProtocol.h"

@interface CCAddCommentViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *answerHeaderView;
@property (nonatomic, weak) IBOutlet UIView *addCommentView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextView *commentTextView;
@property (nonatomic, weak) IBOutlet UIScrollView *keyboardAvoidScrollView;

@property (nonatomic, strong) id<CCCommentsApiProviderProtocol> ioc_commentsApiProvider;
@property (nonatomic, strong) CCAnswer *answer;

@end

@implementation CCAddCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupHeaderView];
    [self fixLayout];
    [self setupImageViews];
    
    [self setTitle:@"Add Comment"];
    [self setRightNavigationItemWithTitle:@"Add" selector:@selector(addCommentButtonDidPressed:)];
}

- (void)setupHeaderView
{
    CCAnswerHeader *headerView = [[CCAnswerHeader alloc] initWithAnswerText:self.answer.text bottomDividerVisibile:NO];
    [self.answerHeaderView setBounds:headerView.bounds];
    [self.answerHeaderView addSubview:headerView];
    [CCViewPositioningHelper setOriginY:0 toView:self.answerHeaderView];
}

- (void)fixLayout
{
    [CCViewPositioningHelper setOriginY:[CCViewPositioningHelper bottomOfView:self.answerHeaderView] toView:self.addCommentView];
    [CCViewPositioningHelper setHeight:[CCViewPositioningHelper bottomOfView:self.addCommentView] toView:self.keyboardAvoidScrollView];
}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

#pragma mark -
#pragma mark Actions
- (void)addCommentButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        CCComment *comment = [CCComment commentWithText:self.commentTextView.text];
        comment.answerId = self.answer.answerId;
        [self addComment:comment];
    }
}

#pragma mark -
#pragma mark Validation
- (BOOL)validateInputData
{
    if ([self.commentTextView.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyCommentText];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Requests
- (void)addComment:(CCComment *)comment
{
    __weak CCAddCommentViewController *weakSelf = self;
    [self.ioc_commentsApiProvider postComment:comment successHandler:^(RKMappingResult *result) {
        weakSelf.answer.commentsCount++;
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadComments object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadCellWithAnswer object:nil userInfo:@{@"answer" : weakSelf.answer}];
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.addedComment duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
       [CCStandardErrorHandler showErrorWithError:error]; 
    }];
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

@end
