//
//  CCAddQuestionViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddQuestionViewController.h"
#import "CCQuestion.h"
#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "CCUserSessionProtocol.h"

#import "CCGroup.h"
#import "CCClass.h"

@interface CCAddQuestionViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *questionTextView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, strong) id <CCQuestionsApiProviderProtocol> ioc_questionAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) CCGroup *group;

@property (nonatomic, weak) IBOutlet UIButton *imageDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *pdfDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *imageButton;

@property (nonatomic, strong) NSString *pdfURL;
@property (nonatomic, strong) NSArray *arrayOfURLs;
@property (nonatomic, strong) NSArray *arrayOfImages;

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
        CCQuestion *question = [self prepareQuestion];
        if(self.pdfURL){
            question.pdfUrl = self.pdfURL;
            [self uploadQuestion:question];
        } else if(self.arrayOfURLs){
            question.arrayOfImageUrls = self.arrayOfURLs;
            [self uploadQuestion:question];
        } else if(self.arrayOfImages){
            [self uploadQuestionWithImages:question];
        } else {
           [self uploadQuestion:question]; 
        }
    }
}

- (CCQuestion *)prepareQuestion
{
    CCQuestion *question = [CCQuestion new];
    question.text = self.questionTextView.text;
    question.classId = self.classObject.classID;
    question.groupId = self.group.groupId;
    CCUser *currentUser = [self.ioc_userSession currentUser];
    question.ownerAvatar = currentUser.avatar;
    question.ownerFirstName = currentUser.firstName;
    question.ownerLastName = currentUser.lastName;
    question.createdDate = [NSDate date];
    return question;
}

- (void)uploadQuestionWithImages:(CCQuestion *)question
{
    __weak CCAddQuestionViewController *weakSelf = self;
    id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadManager;
    [[uploadManager uploadingQuestions] addObject:question];
    [self.ioc_questionAPIProvider postUploadInfoWithImages:question
                                                withImages:self.arrayOfImages successHandler:^(id result) {
                                                    [[uploadManager uploadingQuestions] removeObject:question];
                                                    [uploadManager reloadDelegate];
                                                } errorHandler:^(NSError *error) {
                                                    [[uploadManager uploadingQuestions] removeObject:question];
                                                    [uploadManager reloadDelegate];
                                                    [CCStandardErrorHandler showErrorWithError:error];
                                                } progress:^(double finished) {
                                                    [weakSelf.backToListTransaction perform];
                                                    weakSelf.backToListTransaction = nil;
                                                    question.uploadProgress = [NSNumber numberWithDouble:finished];
                                                }];

}

- (void)uploadQuestion:(CCQuestion *)question
{
    [self.ioc_questionAPIProvider postQuestion:question successHandler:^(RKMappingResult *result) {
        [self.backToListTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (IBAction)uploadPhotosButtonDidPressed:(id)sender
{
    if ([self validInputData]) {
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
            self.arrayOfImages = arrayOfImages;
            [self.backToSelfController perform];
            [self unableUploadButtons];
        }];
    }
}

- (IBAction)uploadImagesFromDropboxButtonDidPressed:(id)sender
{
    if ([self validInputData]) {
        [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            self.arrayOfURLs = arrayOfUrls;
            [self.backToSelfController perform];
            [self unableUploadButtons];
        }];
    }
}

- (IBAction)uploadPdfFromDropboxButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            self.pdfURL = arrayOfUrls.lastObject;
            [self.backToSelfController perform];
            [self unableUploadButtons];
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

- (void)unableUploadButtons
{
    self.imageButton.enabled = NO;
    self.imageDropboxButton.enabled = NO;
    self.pdfDropboxButton.enabled = NO;
}

@end
