//
//  CCGroupInviteViewController.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupInviteViewController.h"

#import "CCStringHelper.h"
#import "CCGroup.h"

@interface CCGroupInviteViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *textBackgroundImageView;
@property (nonatomic, weak) IBOutlet UITextView *inviteTextView;

@property (nonatomic, strong) CCGroup *group;

@end

@implementation CCGroupInviteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupImageView];
    
    [self setTitle:@"Group Invite"];
    [self setRightNavigationItemWithTitle:@"Send" selector:@selector(sendInviteButtonDidPressed:)];
}

- (void)setupImageView
{
    [self.textBackgroundImageView setImage:[[UIImage imageNamed:@"text_box"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
}

#pragma mark -
#pragma mark Actions
- (void)sendInviteButtonDidPressed:(id)sender
{
    
}

#pragma mark -
#pragma mark Input Data Validation
- (BOOL)validateInputData
{
    return YES;
}

#pragma mark -
#pragma mark Requests
- (void)sendInvites
{
    
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [CCStringHelper trimSpacesFromString:textView.text];
}

@end
