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
#import "CCProfessorUploadsAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"

@interface CCAddProfessorUploadsController ()

@property (nonatomic, weak) IBOutlet UITextView *uploadTextView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextField *uploadNameLabel;
@property (nonatomic, strong) id <CCQuestionsApiProviderProtocol> ioc_questionAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;
@property (nonatomic, strong) id <CCProfessorUploadsAPIProviderProtocol> ioc_professorAPIProvider;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@property (nonatomic, weak) IBOutlet UIButton *imageDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *pdfDropboxButton;
@property (nonatomic, weak) IBOutlet UIButton *imageButton;

@property (nonatomic, strong) NSString *pdfURL;
@property (nonatomic, strong) NSArray *arrayOfURLs;
@property (nonatomic, strong) NSArray *arrayOfImages;


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

- (void)upload
{
    if ([self validInputData]) {
        CCProfessorUpload *upload = [self prepareProfessorUpload];
        if(self.pdfURL){
            upload.pdfUrl = self.pdfURL;
            [self uploadProfUpload:upload];
        } else if(self.arrayOfURLs){
            upload.arrayOfImageUrls = self.arrayOfURLs;
            [self uploadProfUpload:upload];
        } else if(self.arrayOfImages){
            [self uploadUploadWithImages:upload];
        } 
    }
}

- (void)showDoneButton
{
    [self setRightNavigationItemWithTitle:@"Done" selector:@selector(upload)];
}

- (void)uploadProfUpload:(CCProfessorUpload *)upload
{
    [self.ioc_professorAPIProvider postUploadInfo:upload
                                   ForClassWithId:_currentClass.classID
                                   successHandler:^(RKMappingResult *result) {
                                       [self.backToListTransaction perform];
                                   } errorHandler:^(NSError *error) {
                                       [CCStandardErrorHandler showErrorWithError:error];
                                   }];
}

- (void)uploadUploadWithImages:(CCProfessorUpload *)upload
{
    __weak id weakSelf = self;
    id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadManager;
    [[uploadManager uploadingProfessorUploads] addObject:upload];
    [self.ioc_professorAPIProvider
     postUploadInfo:upload
     ForClassWithId:_currentClass.classID
     withImages:self.arrayOfImages
     successHandler:^(id result) {
         [[uploadManager uploadingProfessorUploads] removeObject:upload];
         [uploadManager reloadDelegate];
     } errorHandler:^(NSError *error) {
         [[uploadManager uploadingProfessorUploads] removeObject:upload];
         [uploadManager reloadDelegate];
         [CCStandardErrorHandler showErrorWithError:error];
     } progress:^(double finished) {
         [[weakSelf backToListTransaction] perform];
         [weakSelf setBackToListTransaction:nil];
         upload.uploadProgress = @(finished);
     }];

}

- (IBAction)uploadImagesFromDropboxButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            self.arrayOfURLs = arrayOfUrls;
            [self unableUploadButtons];
            [self.backToSelfTransaction perform];
            [self showDoneButton];
        }];
    }
}

- (IBAction)uploadPdfFromDropboxButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            self.pdfURL = arrayOfUrls.lastObject;
            [self unableUploadButtons];
            [self.backToSelfTransaction perform];
            [self showDoneButton];
        }];
    }
}

- (IBAction)uploadPhotosButtonDidPressed:(id)sender
{
    if([self validInputData]){
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
            self.arrayOfImages = arrayOfImages;
            [self unableUploadButtons];
            [self.backToSelfTransaction perform];
            [self showDoneButton];
        }];
    }
}

- (CCProfessorUpload *)prepareProfessorUpload
{
    CCProfessorUpload *professorUpload = [CCProfessorUpload new];
    professorUpload.name = self.uploadNameLabel.text;
    professorUpload.text = self.uploadTextView.text;
    CCUser *currentUser = [self.ioc_userSession currentUser];
    professorUpload.ownerAvatar = currentUser.avatar;
    professorUpload.ownerFirstName = currentUser.firstName;
    professorUpload.ownerLastName = currentUser.lastName;
    professorUpload.createdDate = [NSDate date];
    professorUpload.classID = self.currentClass.classID;
    return professorUpload;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
    return YES;
}

- (void)unableUploadButtons
{
    self.imageButton.enabled = NO;
    self.imageDropboxButton.enabled = NO;
    self.pdfDropboxButton.enabled = NO;
}

@end
