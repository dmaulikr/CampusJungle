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
    [testSheet setCancelButtonWithTitle:nil handler:nil];
    [testSheet showInView:[self.delegate view]];
}

- (void)selectAvatarFromGallery
{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
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
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

@end
