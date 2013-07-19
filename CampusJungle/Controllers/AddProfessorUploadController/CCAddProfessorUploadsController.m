//
//  CCAddProfessorUploadsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddProfessorUploadsController.h"
#import "CCProfessorUpload.h"
#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "CCUserSessionProtocol.h"

@interface CCAddProfessorUploadsController ()

@property (nonatomic, weak) IBOutlet UITextView *uploadTextView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextField *uploadNameLabel;
@property (nonatomic, strong) id <CCQuestionsApiProviderProtocol> ioc_questionAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

- (IBAction)uploadPhotosButtonDidPressed:(id)sender;

@end

@implementation CCAddProfessorUploadsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupImageViews];
    
    [self setTitle:@"New Uploads"];
    self.tapRecognizer.enabled = YES;
}

- (IBAction)uploadImagesFromDropboxButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){

        }];
    }
}

- (IBAction)uploadPdfFromDropboxButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){

        }];
    }
}

- (IBAction)uploadPhotosButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
        
        }];
    }
}

- (CCProfessorUpload *)prepareProfessorUpload
{
    

}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

- (BOOL)validInputData
{
    if (![self.uploadNameLabel.text length]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyUploadName];
        return NO;
    }
    if (![self.uploadTextView.text length]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyUploadText];
        return NO;
    }
    return YES;
}

@end
