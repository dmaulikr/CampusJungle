//
//  CCStuffCreationController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffCreationController.h"
#import "CCAvatarSelectionProtocol.h"
#import "CCAvatarSelectionActionSheet.h"
#import "CCActionSheetPickerCollegesDelegate.h"
#import "ActionSheetCustomPicker.h"
#import "CCCollege.h"
#import "CCUserSessionProtocol.h"
#import "CCEducation.h"
#import "MBProgressHUD.h"
#import "NSString+CJStringValidator.h"
#import "CCStuffUploadInfo.h"

@interface CCStuffCreationController () <CCAvatarSelectionProtocol, CCCellSelectionProtocol>

@property (nonatomic, strong) IBOutlet UIImageView *thumbImage;
@property (nonatomic, strong) IBOutlet UITextField *decriptionField;
@property (nonatomic, strong) IBOutlet UITextField *priceField;
@property (nonatomic, strong) IBOutlet UIButton *collegeSelectionButton;

@property (nonatomic, strong) NSArray *arrayOfColleges;

@property (nonatomic, strong) CCAvatarSelectionActionSheet *thumbSelection;

@property (nonatomic, strong) CCCollege *selectedCollege;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;

@end

@implementation CCStuffCreationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.thumbSelection = [CCAvatarSelectionActionSheet new];
    self.thumbSelection.delegate = self;
    self.thumbSelection.title = @"Select thumbnail";
    
    [self loadColleges];
}

- (void)setSelectedCollege:(CCCollege *)selectedCollege
{
    _selectedCollege = selectedCollege;
    [self.collegeSelectionButton setTitle:selectedCollege.name forState:UIControlStateNormal];
}


- (void)loadColleges
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.ioc_userSession loadUserEducationsSuccessHandler:^(id educations) {
        self.arrayOfColleges = [CCEducation arrayOfCollegesFromEducations:educations];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(self.arrayOfColleges.count){
            self.selectedCollege = self.arrayOfColleges[0];
        }
    }];
}

- (IBAction)thumbDidPressed
{
    [self.thumbSelection selectAvatar];
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.thumbImage.image = avatar;
}

- (IBAction)collegeSelectionButtonDidPressed
{
    CCActionSheetPickerCollegesDelegate *delegate = [CCActionSheetPickerCollegesDelegate new];
    delegate.arrayOfItems = self.arrayOfColleges;
    delegate.delegate = self;
    [ActionSheetCustomPicker showPickerWithTitle:@"Colleges" delegate:delegate showCancelButton:YES origin:self.view];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    self.selectedCollege = cellObject;
}

- (IBAction)didPressedDropboxImagesSelectionButton
{
    if([self isFieldsValid]){
        [self.selectFilesFromDropboxTransaction performWithObject:[self createUploadInfo]];
    }
}

- (BOOL)isFieldsValid
{
    if ([self.decriptionField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.descriptionCantBeBlank];
        return NO;
    }
    if ([self.priceField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.priceCantBeBlank];
        return NO;
    }
    return YES;
}

- (CCStuffUploadInfo *)createUploadInfo
{
    CCStuffUploadInfo *uploadInfo = [CCStuffUploadInfo new];
    uploadInfo.stuffDescription = self.decriptionField.text;
    uploadInfo.thumbnail = self.thumbImage.image;
    uploadInfo.price = [NSNumber numberWithInteger: self.priceField.text.integerValue];
    uploadInfo.collegeID = self.selectedCollege.collegeID.stringValue;
    return uploadInfo;
}

- (void)didPressedImagesUploadingButton
{
    if([self isFieldsValid]){
        [self.imagesUploadTransaction performWithObject:[self createUploadInfo]];
    }
}

@end
