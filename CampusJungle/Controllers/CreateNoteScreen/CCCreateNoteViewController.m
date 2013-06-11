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
#import "UIActionSheet+BlocksKit.h"

@interface CCCreateNoteViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *priceField;
@property (nonatomic, weak) IBOutlet UITextField *fullAccessPriceField;
@property (nonatomic, weak) IBOutlet UITextField *descriptionField;
@property (nonatomic, weak) IBOutlet UIImageView *thumbView;

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
    if ([self.fullAccessPriceField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Full access price can not be blank"];
        return NO;
    }
    
    if (self.fullAccessPriceField.text.integerValue < self.priceField.text.integerValue){
        [CCStandardErrorHandler showErrorWithTitle:nil message:@"Full access price can not lower then price for review"];
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

- (IBAction)UploadPhotosDidPressed
{
    if([self isFieldsValid]){
        [self.imagesUploadTransaction performWithObject:[self createUploadInfo]];
    }
}

- (CCNoteUploadInfo *)createUploadInfo
{
    CCNoteUploadInfo *noteInfo = [CCNoteUploadInfo new];
    noteInfo.noteDescription = self.descriptionField.text;
    noteInfo.price = [NSNumber numberWithInteger:self.priceField.text.integerValue];
    noteInfo.fullPrice = [NSNumber numberWithInteger:self.fullAccessPriceField.text.integerValue];
    noteInfo.collegeID = @20429;
    noteInfo.thumbnail = self.thumbView.image;
    return noteInfo;
}

- (IBAction)thumbDidPressed
{
    
        UIActionSheet *testSheet = [UIActionSheet actionSheetWithTitle:@"Select Avatar"];
        [testSheet addButtonWithTitle:@"Select from gallery" handler:^{
            [self selectAvatarFromGallery];
        }];
        [testSheet addButtonWithTitle:@"Make photo" handler:^{
            [self makePhotoForAvatar];
        }];
        [testSheet setCancelButtonWithTitle:nil handler:nil];
        [testSheet showInView:self.view];
}

- (void)selectAvatarFromGallery
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)makePhotoForAvatar
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.thumbView.image = info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
