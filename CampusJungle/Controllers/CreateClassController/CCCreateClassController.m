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

@interface CCCreateClassController () <UITextFieldDelegate>

{
    NSString *timetableDay;
    NSString *timetableTime;
}

@property (nonatomic, weak) IBOutlet UITextField *subjectTextField;
@property (nonatomic, weak) IBOutlet UITextField *semesterTextField;
@property (nonatomic, weak) IBOutlet UITextField *professorTextField;
@property (nonatomic, weak) IBOutlet UITextField *classIdTextField;
@property (nonatomic, weak) IBOutlet UITextField *timeTableTextField;

@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic, strong) NSArray *textFieldsArray;
@property (nonatomic, strong) NSMutableArray *timetableArray;
@property (nonatomic, strong) NSString *collegeId;
@property (nonatomic, strong) id<CCClassesApiProviderProtocol> ioc_apiClassesProvider;

@end

@implementation CCCreateClassController

- (id)initWithCollegeID:(NSString *)collegeId
{
    self = [super init];
    if (self) {
        self.collegeId = collegeId;
        self.timetableArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Create New Class"];
    [self setupScrollView];
    [self setupTextFields];
    [self addObservers];
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)setupScrollView
{
    [self.scrollView setContentSize:self.scrollView.bounds.size];
}

- (void)setupTextFields
{
    self.textFieldsArray = @[self.subjectTextField, self.professorTextField, self.semesterTextField, self.timeTableTextField];
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
    CCClass *class = [CCClass new];
    class.collegeID = self.collegeId;
    class.professor = self.professorTextField.text;
    class.subject = self.subjectTextField.text;
    class.semester = self.semesterTextField.text;
    class.callNumber = self.classIdTextField.text;
    class.timetable = self.timetableArray;
    
    [self.ioc_apiClassesProvider createClass:class successHandler:^(id newClass) {
        [self joinClass:(CCClass*)newClass];
        
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)getTimeTable:(NSNotification *)notification
{
    self.timeTableTextField.text = [[notification userInfo] objectForKey:@"timetable"];
    timetableDay = [[notification userInfo] objectForKey:@"day"];
    timetableTime = [[notification userInfo] objectForKey:@"time"];
    [self.timetableArray addObject:@{@"day":timetableDay, @"time":timetableTime}];
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
    if (textField == self.timeTableTextField){
        [self createClass:nil];
    }
    else {
        [[self.view viewWithTag:textField.tag + 1] becomeFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.timeTableTextField) {
        [self selectTimeTable:textField];
        return NO;
    }
    return YES;
}

@end
