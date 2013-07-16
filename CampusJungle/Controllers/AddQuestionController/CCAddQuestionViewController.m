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

@interface CCAddQuestionViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *questionTextView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;

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
        [self addQuestion:question];
    }
}

- (IBAction)uploadPhotosButtonDidPressed:(id)sender
{
    
}

- (IBAction)uploadImagesFromDropboxButtonDidPressed:(id)sender
{
    
}

- (IBAction)uploadPdfFromDropboxButtonDidPressed:(id)sender
{
    
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
- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [CCStringHelper trimSpacesFromString:textView.text];
}

#pragma mark -
#pragma mark Requests
- (void)addQuestion:(CCQuestion *)question
{
    
}


@end
