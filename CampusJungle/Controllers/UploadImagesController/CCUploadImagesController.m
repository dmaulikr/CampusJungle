//
//  CCUploadImagesController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUploadImagesController.h"
#import "UIActionSheet+BlocksKit.h"
#import "CCImageCell.h"
#import "CCImageSortingDataSource.h"
#import "CCNotesAPIProviderProtolcol.h"
#import "CCUIImageHelper.h"
#import "CCStandardErrorHandler.h"
#import "MBProgressHUD.h"
#import "CCUploadProcessManagerProtocol.h"

#define animationDuration 0.3
#define maxNumberOfImages 6

@interface CCUploadImagesController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *tableFooterView;
@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadingManager;

@end

@implementation CCUploadImagesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Select Images";
    self.dataSourceClass = [CCImageSortingDataSource class];
    self.mainTable.editing = YES;
    self.mainTable.tableFooterView = self.tableFooterView;
    [self setButtonsTextColorInView:self.tableFooterView];
    self.dataProvider = [CCUploadingImagesDataProvider new];
    self.dataProvider.arrayOfImages = [NSMutableArray new];
    [self configTableWithProvider:self.dataProvider cellClass:[CCImageCell class]];
}

- (IBAction)addImageButtonDidPressed
{
    UIActionSheet *testSheet = [UIActionSheet actionSheetWithTitle:@"Select Avatar"];
    [testSheet addButtonWithTitle:@"Select from gallery" handler:^{
        [self selectAvatarFromGallery];
    }];
    [testSheet addButtonWithTitle:@"Make photo" handler:^{
        [self makePhotoForAvatar];
    }];
    [testSheet setCancelButtonWithTitle:nil handler:nil];
    [testSheet showInView:self.view];

}

- (void)selectAvatarFromGallery
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateNormal];
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)makePhotoForAvatar
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateNormal];
    [[UIButton appearance] setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *fixedImage = [CCUIImageHelper fixOrientationOfImage:info[UIImagePickerControllerOriginalImage]];
    [self.dataProvider.arrayOfImages addObject:fixedImage];
    [self.dataProvider loadItems];
    [self setCustomButton];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self didUpdate];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self setCustomButton];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setCustomButton
{
    UIImage *customButtonBackground = [[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
    
    UIImage *customButtonActiveBackground = [UIImage imageNamed:@"button_active"];
    
    [[UIButton appearance] setBackgroundImage:customButtonBackground forState:UIControlStateNormal];
    
    [[UIButton appearance] setBackgroundImage:customButtonActiveBackground forState:UIControlStateHighlighted];

}

- (void)didUpdate
{
    if(self.dataProvider.arrayOfImages.count){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(sendFiles)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        if(self.dataProvider.arrayOfImages.count >= maxNumberOfImages) {
            self.addButton.alpha = 0;
        } else {
            self.addButton.alpha = 1;
        }
    }];
}

- (void)sendFiles
{
    self.uploadInfo.arrayOfImages = self.dataProvider.arrayOfImages;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Preparing for upload";
    __weak id weakSelf = self;
    CCNoteUploadInfo *uploadInfo = self.uploadInfo;
    id <CCUploadProcessManagerProtocol> uploadManager = self.ioc_uploadingManager;
    [[self.ioc_uploadingManager uploadingNotes] addObject:self.uploadInfo];
    [self.ioc_notesAPIProvider postUploadInfoWithImages:self.uploadInfo successHandler:^(id result) {
        [[uploadManager uploadingNotes] removeObject:uploadInfo];
        [uploadManager reloadDelegate];
    } errorHandler:^(NSError *error) {
        [[uploadManager uploadingNotes] removeObject:uploadInfo];
        [CCStandardErrorHandler showErrorWithError:error];
        [uploadManager reloadDelegate];
    } progress:^(double finished) {
        [[weakSelf backToListTransaction] perform];
        uploadInfo.uploadProgress = [NSNumber numberWithDouble:finished];
    }];
}

@end
