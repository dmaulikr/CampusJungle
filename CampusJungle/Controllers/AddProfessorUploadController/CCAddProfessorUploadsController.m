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
        CCProfessorUpload *professorUpload = [self prepareProfessorUpload];
        [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            professorUpload.arrayOfImageUrls = arrayOfUrls;
            [self.ioc_professorAPIProvider postUploadInfo:professorUpload
                                           ForClassWithId:_currentClass.classID
                                           successHandler:^(RKMappingResult *result) {
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
        CCProfessorUpload *professorUpload = [self prepareProfessorUpload];
        [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
            professorUpload.pdfUrl = [arrayOfUrls lastObject];
            [self.ioc_professorAPIProvider postUploadInfo:professorUpload
                                           ForClassWithId:_currentClass.classID
                                           successHandler:^(RKMappingResult *result) {
                                               [self.backToListTransaction perform];
                                           } errorHandler:^(NSError *error) {
                                               [CCStandardErrorHandler showErrorWithError:error];
                                           }];
        }];
    }
}

- (IBAction)uploadPhotosButtonDidPressed:(id)sender
{
    if([self validInputData]){
        CCProfessorUpload *professorUpload = [self prepareProfessorUpload];
        [self.imagesUploadTransaction performWithObject:^(NSArray *arrayOfImages){
            __weak id weakSelf = self;
            id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadManager;
            [[uploadManager uploadingProfessorUploads] addObject:professorUpload];
            [self.ioc_professorAPIProvider
             postUploadInfo:professorUpload
             ForClassWithId:_currentClass.classID
                 withImages:arrayOfImages
             successHandler:^(id result) {
                    [[uploadManager uploadingProfessorUploads] removeObject:professorUpload];
                    [uploadManager reloadDelegate];
             } errorHandler:^(NSError *error) {
                 [[uploadManager uploadingProfessorUploads] removeObject:professorUpload];
                 [uploadManager reloadDelegate];
                 [CCStandardErrorHandler showErrorWithError:error];
             } progress:^(double finished) {
                 [[weakSelf backToListTransaction] perform];
                 professorUpload.uploadProgress = @(finished);
             }];
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

@end
