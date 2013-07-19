//
//  CCAddQuestionViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddQuestionViewController.h"
#import "CCForum.h"
#import "CCQuestion.h"
#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "CCUserSessionProtocol.h"

@interface CCAddQuestionViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *questionTextView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, strong) id <CCQuestionsApiProviderProtocol> ioc_questionAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) CCForum *forum;

@end

@implementation CCAddQuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupImageViews];
    
    [self setTitle:@"Add Question"];
    [self setRightNavigationItemWithTitle:@"Add" selector:@selector(addButtonDidPressed:)];
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

#pragma mark -
#pragma mark Actions
- (void)addButtonDidPressed:(id)sender
{
    if ([self validInputData]) {
        CCQuestion *question = [CCQuestion new];
        question.text = self.questionTextView.text;
        question.forumId = self.forum.forumId;
        [self addQuestion:question];
    }
}

- (CCQuestion *)prepareQuestion
{
    CCQuestion *question = [CCQuestion new];
    question.text = self.questionTextView.text;
    question.forumId = self.forum.forumId;
    CCUser *currentUser = [self.ioc_userSession currentUser];
    question.ownerAvatar = currentUser.avatar;
    question.ownerFirstName = currentUser.firstName;
    question.ownerLastName = currentUser.lastName;
    question.createdDate = [NSDate date];
    return question;
}

- (IBAction)uploadPhotosButtonDidPressed:(id)sender
{
    if ([self validInputData]) {
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
            CCQuestion *question = [self prepareQuestion];
            __weak id weakSelf = self;
            id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadManager;
            [[uploadManager uploadingQuestions] addObject:question];
            [self.ioc_questionAPIProvider postUploadInfoWithImages:question
                                                    withImages:arrayOfImages successHandler:^(id result) {
                                    [[uploadManager uploadingQuestions] removeObject:question];
                                                         [uploadManager reloadDelegate];
                                                    } errorHandler:^(NSError *error) {
                                                        [[uploadManager uploadingQuestions] removeObject:question];
                                                        [uploadManager reloadDelegate];
                                                        [CCStandardErrorHandler showErrorWithError:error];
                                                    } progress:^(double finished) {
                                                        [[weakSelf backToListTransaction] perform];
                                                        question.uploadProgress = [NSNumber numberWithDouble:finished];
                                                    }];
            }];
        }
}

- (IBAction)uploadImagesFromDropboxButtonDidPressed:(id)sender
{
    if ([self validInputData]) {
        [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            CCQuestion *question = [self prepareQuestion];
            question.arrayOfImageUrls = arrayOfUrls;
            [self.ioc_questionAPIProvider postQuestion:question successHandler:^(RKMappingResult *result) {
            [self.backToListTransaction perform];
            } errorHandler:^(NSError *error) {
                [CCStandardErrorHandler showErrorWithError:error];
            }];
        }];
    }
}

- (IBAction)uploadPdfFromDropboxButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            CCQuestion *question = [self prepareQuestion];
            question.pdfUrl = arrayOfUrls.lastObject;
            [self.ioc_questionAPIProvider postQuestion:question successHandler:^(RKMappingResult *result) {
                [self.backToListTransaction perform];
            } errorHandler:^(NSError *error) {
                [CCStandardErrorHandler showErrorWithError:error];
            }];
        }];
    }
}

- (BOOL)validInputData
{
    if ([self.questionTextView.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyQuestionText];
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
- (void)addQuestion:(CCQuestion *)question
{
    [self.ioc_questionAPIProvider postQuestion:question successHandler:^(RKMappingResult *result) {
        [self.backToListTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}


@end
