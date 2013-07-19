//
//  CCAvatarSelectionActionSheet.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAvatarSelectionActionSheet.h"
#import "UIActionSheet+BlocksKit.h"

#import "CCBaseActionSheet.h"
#import "CCShareItemButton.h"

@interface CCAvatarSelectionActionSheet ()

@property (nonatomic, strong) CCBaseActionSheet *actionSheet;
@property (nonatomic, strong) NSString *takePhotoButtonTitle;
@property (nonatomic, strong) NSString *takeFromGalleryButtonTitle;

@end

@implementation CCAvatarSelectionActionSheet

- (void)showWithTitle:(NSString *)title takePhotoButtonTitle:(NSString *)takePhotoButtonTitle takeFromGalleryButtonTitle:(NSString *)takeFromGalleryButtonTitle
{
    self.takePhotoButtonTitle = takePhotoButtonTitle ? takePhotoButtonTitle : @"Take a photo";
    self.takeFromGalleryButtonTitle = takeFromGalleryButtonTitle ? takeFromGalleryButtonTitle : @"Take from gallery";
    self.actionSheet = [[CCBaseActionSheet alloc] initWithTitle:title buttonsArray:[self buttonsArray]];
    [self.actionSheet show];
}

- (void)dismiss
{
    if (self.actionSheet) {
        [self.actionSheet dismiss];
    }
}

- (NSArray *)buttonsArray
{
    __weak CCAvatarSelectionActionSheet *weakSelf = self;
    CCShareItemButton *takePhotoButton = [CCShareItemButton buttonWithTitle:self.takePhotoButtonTitle actionBlock:^{
        [weakSelf.actionSheet dismiss];
        [self makePhotoForAvatar];
    }];
    CCShareItemButton *takeFromGalleryButton = [CCShareItemButton buttonWithTitle:self.takeFromGalleryButtonTitle actionBlock:^{
        [weakSelf.actionSheet dismiss];
        [self selectAvatarFromGallery];
    }];
    CCShareItemButton *cancelButton = [CCShareItemButton buttonWithTitle:@"Cancel" actionBlock:^{
        [weakSelf.actionSheet dismiss];
    }];

    return @[takePhotoButton, takeFromGalleryButton, cancelButton];
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
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateNormal];
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateHighlighted];
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
