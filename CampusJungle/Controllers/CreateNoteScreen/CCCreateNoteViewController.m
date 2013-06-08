//
//  CCCreateNoteViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 07.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateNoteViewController.h"
#import "CCNoteUploadInfo.h"
#import "NSString+CJStringValidator.h"
#import "CCStandardErrorHandler.h"

@interface CCCreateNoteViewController ()

@property (nonatomic, weak) IBOutlet UITextField *priceField;
@property (nonatomic, weak) IBOutlet UITextField *descriptionField;

@end

@implementation CCCreateNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)isFieldsValid
{
    if ([self.descriptionField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Description can not be blank"];
        return NO;
    }
    if ([self.priceField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Price can not be blank"];
        return NO;
    }
    return YES;
}

- (IBAction)imagesFromDropBoxButtonDidPressed
{
    if([self isFieldsValid]){
        [self.imagesDropboxUploadTransaction performWithObject:[self createUploadInfo]];
    }

}

- (IBAction)pdfFromDropboxButtonDidPressed
{
    if([self isFieldsValid]){
        [self.pdfDropboxUploadTransaction performWithObject:[self createUploadInfo]];
    }
}

- (CCNoteUploadInfo *)createUploadInfo
{
    CCNoteUploadInfo *noteInfo = [CCNoteUploadInfo new];
    noteInfo.noteDescription = self.descriptionField.text;
    noteInfo.price = [NSNumber numberWithInteger:self.priceField.text.integerValue];
    noteInfo.collegeID = @20429;
    return noteInfo;
}

@end
