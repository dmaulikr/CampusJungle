//
//  CCCreateClassController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateClassController.h"
#import "CCClass.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CCStandardErrorHandler.h"
#import "ActionSheetPicker.h"
#import "CCActionSheetPickerDateDelegate.h"

#import "CCTimeTableCell.h"
#import "AbstractActionSheetPicker.h"
#import "CCClassCreationDataSource.h"
#import "CCAvatarSelectionActionSheet.h"

#import "CCButtonsHelper.h"

@interface CCCreateClassController () <UITextFieldDelegate,  DatePickerDelegateProtocol,CCAvatarSelectionProtocol>
{
    NSString *timetableDay;
    NSString *timetableTime;
}

@property (nonatomic, weak) UIView *pickerContainer;
@property (nonatomic, weak) id actionSheetPicker;
@property (nonatomic, strong) CCAvatarSelectionActionSheet *thumbSelectionSheet;
@property (nonatomic, weak) IBOutlet UIButton *thumbButton;
@property (nonatomic, strong) NSArray *textFieldsArray;

@property (nonatomic, strong) id<CCClassesApiProviderProtocol> ioc_apiClassesProvider;

- (IBAction)thumbDidPressed;

@end

@implementation CCCreateClassController

- (id)initWithCollegeID:(NSString *)collegeId
{
    self = [super init];
    if (self) {
        self.collegeId = collegeId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"New Class"];
    [self setupTextFields];
    [self addObservers];
    self.dataSourceClass = [CCClassCreationDataSource class];
    self.tableDataProvider = [CCTimeTableDataProvider new];
    [self configAvatarSelectionSheet];
    [self configTableWithProvider:self.tableDataProvider cellClass:[CCTimeTableCell class]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(createClass:)];
    self.thumbView.image = [UIImage imageNamed:@"avatar_placeholder"];
    [CCButtonsHelper removeBackgroundImageInButton:self.thumbButton];
}

- (void)configAvatarSelectionSheet
{
    self.thumbSelectionSheet = [CCAvatarSelectionActionSheet new];
    self.thumbSelectionSheet.delegate = self;
}

- (IBAction)thumbDidPressed
{
    [self.thumbSelectionSheet showWithTitle:@"Select Class Thumbnail" takePhotoButtonTitle:nil takeFromGalleryButtonTitle:nil];
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    self.thumbView.image = avatar;
    self.isAvatarUpdated = YES;
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)setupTextFields
{
    self.textFieldsArray = @[self.classNameTextField,self.subjectTextField, self.professorTextField, self.semesterTextField];
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTimeTable:) name:@"Timetable" object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Timetable" object:nil];
}

#pragma mark -
#pragma mark Actions
- (IBAction)selectTimeTable:(UIControl *)sender
{
    CCActionSheetPickerDateDelegate *delegate = [[CCActionSheetPickerDateDelegate alloc] init];
    [ActionSheetCustomPicker showPickerWithTitle:@"Timetable" delegate:delegate showCancelButton:YES origin:sender];
}

- (IBAction)createClass:(id)sender
{    
    if (![self isFormValid]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.emptyField];
        return;
    }
    
    [self.ioc_apiClassesProvider createClass:[self prepareClass] successHandler:^(id newClass) {
        [self joinClass:(CCClass*)newClass];
        
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (CCClass *)prepareClass
{
    CCClass *class = [CCClass new];
    class.name = self.classNameTextField.text;
    class.collegeID = self.collegeId;
    class.professor = self.professorTextField.text;
    class.subject = self.subjectTextField.text;
    class.semester = self.semesterTextField.text;
    class.callNumber = self.classIdTextField.text;
    class.timetable = [self.tableDataProvider.arrayOfLessons mutableCopy];
    if(self.isAvatarUpdated){
        class.thumb = self.thumbView.image;
    }
    NSLog(@"%@",class.timetable);
    [(NSMutableArray *)class.timetable removeObjectAtIndex:0];
    return class;
}

- (void)joinClass:(CCClass *)class
{
   [self.ioc_apiClassesProvider joinClass:class.classID SuccessHandler:^(id response) {
       [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadSideMenu object:nil];
       [self.classAddedTransaction performWithObject:class];
   } errorHandler:^(NSError *error) {
      [CCStandardErrorHandler showErrorWithError:error]; 
   }];
}

#pragma mark -
#pragma mark Data Validation
- (BOOL)isFormValid
{
    BOOL isFormValid = YES;
    for (UITextField *textField in self.textFieldsArray) {
        if ([textField.text length] == 0)  {
            isFormValid = NO;
            break;
        }
    }
    return isFormValid;
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.semesterTextField){
        [self.view endEditing:YES];
    }
    else {
        [[self.view viewWithTag:textField.tag + 1] becomeFirstResponder];
    }
    return YES;
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    NSDictionary *date = cellObject;
    
    if (!date[@"time"]){
        date = nil;
    }
    
    CCActionSheetPickerDateDelegate *delegate = [[CCActionSheetPickerDateDelegate alloc] initWithDate:date];
    delegate.delegate = self;
    
    ActionSheetCustomPicker *actionSheetPicker = [ActionSheetCustomPicker showPickerWithTitle:@"Timetable" delegate:delegate showCancelButton:YES origin:self.view];
    self.pickerContainer = actionSheetPicker.pickerView.superview;
    self.actionSheetPicker = actionSheetPicker;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOut:)];
    tap.cancelsTouchesInView = NO;
    [actionSheetPicker.pickerView.window addGestureRecognizer:tap];
    
}

- (void)tapOut:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.pickerContainer];
    if(p.y < 0){
        [self.actionSheetPicker performSelector:@selector(dismissPicker)];
    }
}

- (void)lessonDidCreate:(NSDictionary *)lesson
{
    [self.tableDataProvider insertNewLesson:lesson];
}

- (void)lesson:(NSDictionary *)lesson didUpdateWithObject:(NSDictionary *)newLesson
{
    [self.tableDataProvider replaseTime:lesson withTime:newLesson];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (void)deleteCellObject:(NSDictionary *)object{
    NSInteger objectIndex = [self.tableDataProvider.arrayOfLessons indexOfObject:object];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:objectIndex inSection:0];
    [(NSMutableArray *) self.tableDataProvider.arrayOfItems removeObjectAtIndex:(NSUInteger) objectIndex];
    [self.mainTable beginUpdates];
    [self.mainTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.mainTable endUpdates];
}

@end
