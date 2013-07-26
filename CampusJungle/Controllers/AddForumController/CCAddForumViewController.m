//
//  CCAddForumViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddForumViewController.h"
#import "CCClass.h"
#import "CCForum.h"
#import "CCGroup.h"
#import "CCStandardErrorHandler.h"

#import "CCForumsApiProviderProtocol.h"
#import "CCUserSessionProtocol.h"
#import "CCStringHelper.h"

@interface CCAddForumViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *descriptionTextField;

@property (nonatomic, strong) CCClass *classObject;
@property (nonatomic, strong) CCGroup *group;
@property (nonatomic, strong) id<CCForumsApiProviderProtocol> ioc_forumsApiProvider;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;

@end

@implementation CCAddForumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setRightNavigationItemWithTitle:@"Add" selector:@selector(addForumButtonDidPressed:)];
    [self setTitle:@"Add Forum"];
    [(UIScrollView *)self.view setScrollEnabled:NO];
}

- (void)setClass:(CCClass *)classObject
{
    _classObject = classObject;
}

#pragma mark -
#pragma mark Actions
- (void)addForumButtonDidPressed:(id)sender
{
    if ([self validateInputData]) {
        CCForum *forumToAdd = [self createForumObject];
        if (self.classObject) {
            [self addToClassForum:forumToAdd];
        }
        else {
            [self addToGroupForum:forumToAdd];
        }
    }
}

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

- (CCForum *)createForumObject
{
    CCForum *forum = [CCForum new];
    forum.ownerId = self.ioc_userSessionProvider.currentUser.uid;
    forum.name = self.nameTextField.text;
    forum.description = self.descriptionTextField.text;
    if (self.classObject) {
        forum.classId = self.classObject.classID;
    }
    else {
        forum.groupId = self.group.groupId;
    }

    return forum;
}

#pragma mark -
#pragma mark UITextFieldDelegate
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [CCStringHelper trimSpacesFromString:textField.text];
}

#pragma mark -
#pragma mark Requests
- (void)addToClassForum:(CCForum *)forum
{
    __weak CCAddForumViewController *weakSelf = self;
    [self.ioc_forumsApiProvider postInClassForum:forum successHandler:^(RKMappingResult *object) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.addedForum duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)addToGroupForum:(CCForum *)forum
{
    __weak CCAddForumViewController *weakSelf = self;
    [self.ioc_forumsApiProvider postInGroupForum:forum successHandler:^(RKMappingResult *object) {
        [SVProgressHUD showSuccessWithStatus:CCSuccessMessages.addedForum duration:CCProgressHudsConstants.loaderDuration];
        [weakSelf.backTransaction perform];
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
