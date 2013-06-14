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
#import "CCAlertDefines.h"
#import "ActionSheetPicker.h"
#import "CCActionSheetPickerDelegate.h"

@interface CCCreateClassController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_apiClassesProvider;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextField *semesterField;
@property (weak, nonatomic) IBOutlet UITextField *professorField;
@property (weak, nonatomic) IBOutlet UITextField *classIDFiled;
@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) NSArray *textFieldsArray;

@property (weak, nonatomic) IBOutlet UITextField *timeTable;


@end

@implementation CCCreateClassController

- (id)initWithCollegeID:(NSString*)collegeID
{
self = [super init];
if (self) {
    self.collegeID = collegeID;
    [self.navigationItem setTitle:@"Create new class"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTimeTable:) name:@"Timetable" object:nil];

}
return self;
}

- (void)getTimeTable:(NSNotification*)notification
{
    self.timeTable.text = [[notification userInfo] objectForKey:@"timetable"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textFieldsArray = @[self.subjectField, self.semesterField, self.professorField, self.classIDFiled];
    for (UITextField *tf in self.textFieldsArray) {
        tf.delegate = self;
    }
}

- (IBAction)createClass:(id)sender {
    
    if (![self isFormValid]) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsMessages.error message:CCAlertsMessages.emptyField];
        return;
    }
    CCClass *class = [CCClass new];
    class.collegeID = self.collegeID;
    class.professor = self.professorField.text;
    class.subject = self.subjectField.text;
    class.semester = self.semesterField.text;
    class.callNumber = self.classIDFiled.text;
    class.timetable = @[@{@"day":@"Tue", @"time":@"23:00"}];
    
    [self.ioc_apiClassesProvider createClass:class successHandler:^(id newClass) {
        [self joinClass:(CCClass*)newClass];
        
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)joinClass:(CCClass*)class
{
   [self.ioc_apiClassesProvider joinClass:class.classID SuccessHandler:^(id response) {
       [self.classAddedTransaction perform];
   } errorHandler:^(NSError *error) {
      [CCStandardErrorHandler showErrorWithError:error]; 
   }];
}

- (BOOL)isFormValid
{
    BOOL isFormValid = YES;
    
    for (UITextField *tf in self.textFieldsArray) {
        if ([tf.text isEqualToString:@""])  {
            isFormValid = NO;
        }
    }
    return isFormValid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.timeTable){
        [self createClass:nil];
    } else {
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        return YES;
    }
    return YES;
}

- (IBAction)selectTimeTable:(UIControl *)sender {
    
    CCActionSheetPickerDelegate *delegate = [[CCActionSheetPickerDelegate alloc] init];
    [ActionSheetCustomPicker showPickerWithTitle:@"Timetable" delegate:delegate showCancelButton:YES origin:sender];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 4:
            [self selectTimeTable:textField];
            return NO;
            break;
            
        default:
            return YES;
            break;
    }
}


@end
