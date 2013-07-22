//
//  CCAddGroupViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddGroupViewController.h"
#import "CCClass.h"
#import "CCGroup.h"
#import "CCGroupsApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCStringHelper.h"

@interface CCAddGroupViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *descriptionTextField;

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;

@end

@implementation CCAddGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Add Group"];
    [self setRightNavigationItemWithTitle:@"Add" selector:@selector(addGroupButtonDidPressed:)];
}

#pragma mark -
#pragma mark Actions
- (void)addGroupButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        CCGroup *group = [CCGroup createWithName:self.nameTextField.text description:self.descriptionTextField.text];
        group.classId = self.classObject.classID;
        [self addGroup:group];
    }
}

#pragma mark -
#pragma mark Input Data Validation
- (BOOL)validateInputData
{
    if ([self.nameTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyName];
        return NO;
    }
    if ([self.descriptionTextField.text length] == 0) {
        [CCStandardErrorHandler showErrorWithTitle:CCAlertsTitles.defaultError message:CCValidationMessages.emptyDescription];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Requests
- (void)addGroup:(CCGroup *)group
{
    __weak CCAddGroupViewController *weakSelf = self;
    [self.ioc_groupsApiProvider createGroup:group successHandler:^(RKMappingResult *result) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.addedGroup duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [CCStringHelper trimSpacesFromString:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        [self.descriptionTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
