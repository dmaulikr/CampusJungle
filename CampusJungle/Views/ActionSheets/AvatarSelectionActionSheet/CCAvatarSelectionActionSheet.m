//
//  CCAvatarSelectionActionSheet.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAvatarSelectionActionSheet.h"
#import "UIActionSheet+BlocksKit.h"

@implementation CCAvatarSelectionActionSheet

- (void)selectAvatar
{
    UIActionSheet *testSheet = [UIActionSheet actionSheetWithTitle:self.title];
    [testSheet addButtonWithTitle:@"Select from gallery" handler:^{
        [self selectAvatarFromGallery];
    }];
    [testSheet addButtonWithTitle:@"Make photo" handler:^{
        [self makePhotoForAvatar];
    }];
    [testSheet setCancelButtonWithTitle:nil handler:^{
        [self setButtonAppearance];   
    }];
    [testSheet showInView:[self.delegate view]];
}

- (void)selectAvatarFromGallery
{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateNormal];
    
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self.delegate presentViewController:picker animated:YES completion:nil];
}

- (void)makePhotoForAvatar
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self.delegate presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.delegate didSelectAvatar:info[UIImagePickerControllerEditedImage]];
    [self setButtonAppearance];
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self setButtonAppearance];
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (void)setButtonAppearance
{
    UIImage *customButtonBackground = [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
    
    UIImage *customButtonActiveBackground = [UIImage imageNamed:@"button_active"];
    
    [[UIButton appearance] setBackgroundImage:customButtonBackground forState:UIControlStateNormal];
    
    [[UIButton appearance] setBackgroundImage:customButtonActiveBackground forState:UIControlStateHighlighted];
}

@end
