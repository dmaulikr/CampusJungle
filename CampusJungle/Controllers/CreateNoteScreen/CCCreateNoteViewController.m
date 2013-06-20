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
#import "CCUserSessionProtocol.h"
#import "CCCollege.h"
#import "CCEducation.h"
#import "CCAlertDefines.h"
#import "CCClassesApiProviderProtocol.h"
#import "MBProgressHUD.h"
#import "ActionSheetCustomPicker.h"
#import "CCActionSheetPickerCollegesDelegate.h"
#import "CCAvatarSelectionProtocol.h"
#import "CCAvatarSelectionActionSheet.h"

@interface CCCreateNoteViewController ()<CCCellSelectionProtocol,CCAvatarSelectionProtocol>

@property (nonatomic, weak) IBOutlet UITextField *priceField;
@property (nonatomic, weak) IBOutlet UITextField *fullAccessPriceField;
@property (nonatomic, weak) IBOutlet UITextField *descriptionField;
@property (nonatomic, weak) IBOutlet UIImageView *thumbView;
@property (nonatomic, weak) IBOutlet UIButton *collegeSelectionButton;
@property (nonatomic, weak) IBOutlet UIButton *classesSelectionButton;
@property (nonatomic, strong) CCAvatarSelectionActionSheet *thumbSelectionSheet;

@property (nonatomic, strong) CCCollege *selectedCollege;
@property (nonatomic, strong) CCClass *selectedClass;

@property (nonatomic, strong) NSArray *arrayOfColleges;
@property (nonatomic, strong) NSArray *arrayOfClasses;
@property (nonatomic, strong) id <CCUserSessionProtocol> ioc_userSession;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPI;

@property (nonatomic, strong) NSArray *arrayOfItemsForPicker;

@end

@implementation CCCreateNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New Note";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadCollegesPickerInfo];
    [self loadClasses];
    [self configAvatarSelectionSheet];
}

- (void)configAvatarSelectionSheet
{
    self.thumbSelectionSheet = [CCAvatarSelectionActionSheet new];
    self.thumbSelectionSheet.delegate = self;
    self.thumbSelectionSheet.title = @"Select Thumbnail";
}

- (void)loadClasses
{
    [self.ioc_classesAPI getAllClasesSuccessHandler:^(id classes) {
        self.arrayOfClasses = classes;
        [self checkIsEverythingReady];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)loadCollegesPickerInfo
{
    [self.ioc_userSession loadUserEducationsSuccessHandler:^(id educations) {
        self.arrayOfColleges = [CCEducation arrayOfCollegesFromEducations:educations];
        [self checkIsEverythingReady];
        if(self.arrayOfColleges.count){
            self.selectedCollege = self.arrayOfColleges[0];
        }
    }];
}

- (void)checkIsEverythingReady
{
    if(self.arrayOfClasses && self.arrayOfColleges){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

- (void)setSelectedCollege:(CCCollege *)selectedCollege
{
    _selectedCollege = selectedCollege;
    [self.collegeSelectionButton setTitle:selectedCollege.name forState:UIControlStateNormal];
    self.selectedClass = nil;
    [self.classesSelectionButton setTitle:@"Select Class" forState:UIControlStateNormal];
}

- (void)setSelectedClass:(CCClass *)selectedClass
{
    _selectedClass = selectedClass;
    [self.classesSelectionButton setTitle:selectedClass.name forState:UIControlStateNormal];
}

- (BOOL)isFieldsValid
{
    if ([self.descriptionField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCValidationMessages.descriptionCantBeBlank];
        return NO;
    }
    if ([self.priceField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCValidationMessages.priceCantBeBlank];
        return NO;
    }
    if ([self.fullAccessPriceField.text isEmpty]){
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCValidationMessages.fullPriceCantBeBlank];
        return NO;
    }
    
    if (self.fullAccessPriceField.text.integerValue < self.priceField.text.integerValue){
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCValidationMessages.fullPriceCantBeLowerThenPriceForReview];
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
    noteInfo.classID = [NSNumber numberWithInteger: self.selectedClass.classID.integerValue];
    noteInfo.thumbnail = self.thumbView.image;
    return noteInfo;
}

- (IBAction)thumbDidPressed
{
    [self.thumbSelectionSheet selectAvatar];
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.thumbView.image = avatar;
}

- (IBAction)collegeSelectionButtonDidPressed
{
    CCActionSheetPickerCollegesDelegate *delegate = [CCActionSheetPickerCollegesDelegate new];
    delegate.arrayOfItems = self.arrayOfColleges;
    delegate.delegate = self;
    [ActionSheetCustomPicker showPickerWithTitle:@"Colleges" delegate:delegate showCancelButton:YES origin:self.view];
}

- (IBAction)classSelectionButtonDidPresed
{
    NSArray *classesInSelectedCollege = [self filterArrayOfClasses:self.arrayOfClasses];
    if (classesInSelectedCollege.count){
        CCActionSheetPickerCollegesDelegate *delegate = [CCActionSheetPickerCollegesDelegate new];
        delegate.arrayOfItems = classesInSelectedCollege;
        delegate.delegate = self;
        [ActionSheetCustomPicker showPickerWithTitle:@"Classes" delegate:delegate showCancelButton:YES origin:self.view];
    } else {
        [CCStandardErrorHandler showErrorWithTitle:nil message:CCAlertsMessages.haveNoClassesInSelectedCollege];
    }
}

- (NSArray *)filterArrayOfClasses:(NSArray *)classes
{
    NSMutableArray *arrayOfClasses = [NSMutableArray new];
    for (CCClass *currentClass in classes){
        if([self.selectedCollege.collegeID.stringValue isEqualToString: currentClass.collegeID]){
            [arrayOfClasses addObject:currentClass];
        }
    }
    return arrayOfClasses;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    if([cellObject isKindOfClass:[CCCollege class]]){
        self.selectedCollege = cellObject;
    } else {
        self.selectedClass = cellObject;
    }
}

@end
