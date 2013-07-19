//
//  CCAvatarSelectionActionSheet.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCAvatarSelectionProtocol.h"

@interface CCAvatarSelectionActionSheet : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIViewController <CCAvatarSelectionProtocol> *delegate;

- (void)showWithTitle:(NSString *)title takePhotoButtonTitle:(NSString *)takePhotoButtonTitle takeFromGalleryButtonTitle:(NSString *)takeFromGalleryButtonTitle;
- (void)dismiss;

@end
