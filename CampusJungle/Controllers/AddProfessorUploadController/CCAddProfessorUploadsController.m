//
//  CCAddProfessorUploadsController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddProfessorUploadsController.h"
#import "CCForum.h"
#import "CCQuestion.h"
#import "CCStringHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCUploadProcessManagerProtocol.h"
#import "CCUserSessionProtocol.h"

@interface CCAddProfessorUploadsController ()
@property (nonatomic, weak) IBOutlet UITextView *questionTextView;
@property (nonatomic, weak) IBOutlet UIImageView *textViewBackgroundImageView;
@property (nonatomic, strong) id <CCQuestionsApiProviderProtocol> ioc_questionAPIProvider;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadManager;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
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
    [self.imagesDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
//        CCQuestion *question = [self prepareQuestion];
//        question.arrayOfImageUrls = arrayOfUrls;
//        [self.ioc_questionAPIProvider postQuestion:question successHandler:^(RKMappingResult *result) {
//            [self.backToListTransaction perform];
//        } errorHandler:^(NSError *error) {
//            [CCStandardErrorHandler showErrorWithError:error];
//        }];
    }];
}

- (IBAction)uploadPdfFromDropboxButtonDidPressed:(id)sender
{
    [self.pdfDropboxUploadTransaction performWithObject:^(NSArray *arrayOfUrls){
//        CCQuestion *question = [self prepareQuestion];
//        question.pdfUrl = arrayOfUrls.lastObject;
//        [self.ioc_questionAPIProvider postQuestion:question successHandler:^(RKMappingResult *result) {
//            [self.backToListTransaction perform];
//        } errorHandler:^(NSError *error) {
//            [CCStandardErrorHandler showErrorWithError:error];
//        }];
    }];
}

- (void)setupImageViews
{
    [self.textViewBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}


@end
