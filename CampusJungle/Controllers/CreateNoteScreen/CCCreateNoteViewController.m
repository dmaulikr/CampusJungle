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
#import "CCUserSessionProtocol.h"
#import "CCCollege.h"
#import "CCEducation.h"

@interface CCCreateNoteViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *priceField;
@property (nonatomic, weak) IBOutlet UITextField *fullAccessPriceField;
@property (nonatomic, weak) IBOutlet UITextField *descriptionField;
@property (nonatomic, weak) IBOutlet UIImageView *thumbView;
@property (nonatomic, weak) IBOutlet UIButton *collegeSelectionButton;
@property (nonatomic, strong) NSArray *arrayOfColleges;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, weak) IBOutlet UIView *pickerContainer;

@property (nonatomic, strong) CCCollege *selectedCollege;

@end

@implementation CCCreateNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CCUser *currentUser = [self.ioc_userSession currentUser];
    self.arrayOfColleges = [self arrayOfCollegesFromUser:currentUser];
    if(self.arrayOfColleges.count){
        self.selectedCollege = self.arrayOfColleges[0];
    }
    
    self.pickerContainer.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.pickerContainer.frame.size.height);
    [self.navigationController.view addSubview:self.pickerContainer];
}

- (void)setSelectedCollege:(CCCollege *)selectedCollege
{
    _selectedCollege = selectedCollege;
    [self.collegeSelectionButton setTitle:selectedCollege.name forState:UIControlStateNormal];
}

- (NSArray *)arrayOfCollegesFromUser:(CCUser *)user
{
    NSMutableArray *arrayOfColleges = [NSMutableArray new];
    for(CCEducation *education in user.educations){
        if(![self isArrayOfColleges:arrayOfColleges containCollegeWithID:education.collegeID]){
            CCCollege *newCollege = [CCCollege new];
            newCollege.collegeID = education.collegeID;
            newCollege.name = education.collegeName;
            [arrayOfColleges addObject:newCollege];
        }
    }
    return arrayOfColleges;
}

- (BOOL)isArrayOfColleges:(NSArray *)arrayOfColleges containCollegeWithID:(NSNumber *)newCollegeID
{
    for(CCCollege *college in arrayOfColleges){
        if([college.collegeID isEqualToNumber:newCollegeID]){
            return YES;
        }
    }
    
    return NO;
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
    noteInfo.collegeID = self.selectedCollege.collegeID;
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrayOfColleges.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arrayOfColleges[row] name];
}

- (void)showPicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerContainer.transform = CGAffineTransformMakeTranslation(0,-self.pickerContainer.frame.size.height);
    }];
}

- (void)hidePicker
{
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerContainer.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (IBAction)collegeSelectionButtonDidPressed
{
    [self showPicker];
    self.view.userInteractionEnabled = NO;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCollege = self.arrayOfColleges[row];
    [self hidePicker];
    self.view.userInteractionEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self hidePicker];
    self.view.userInteractionEnabled = YES;
}

@end
