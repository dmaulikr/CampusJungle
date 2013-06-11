//
//  CCUploadImagesController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUploadImagesController.h"
#import "UIActionSheet+BlocksKit.h"
#import "CCUploadingImagesDataProvider.h"
#import "CCImageCell.h"
#import "CCImageSortingDataSource.h"
#import "CCNotesAPIProviderProtolcol.h"
#import "CCUIImageHelper.h"
#import "CCStandardErrorHandler.h"
#import "MBProgressHUD.h"

#define animationDuration 0.3
#define maxNumberOfImages 6

@interface CCUploadImagesController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *tableFooterView;
@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;
@property (nonatomic, strong) CCUploadingImagesDataProvider *dataProvider;
@property (nonatomic, weak) IBOutlet UIButton *addButton;

@end

@implementation CCUploadImagesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceClass = [CCImageSortingDataSource class];
    self.mainTable.editing = YES;
    self.mainTable.tableFooterView = self.tableFooterView;
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
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)makePhotoForAvatar
{
    UIImagePickerController * picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *fixedImage = [CCUIImageHelper fixOrientationOfImage:info[UIImagePickerControllerOriginalImage]];
    [self.dataProvider.arrayOfImages addObject:fixedImage];
    [self.dataProvider loadItems];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self didUpdate];
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
    self.noteInfo.arrayOfImages = self.dataProvider.arrayOfImages;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Preparing for upload";
    [self.ioc_notesAPIProvider postDropboxUploadInfoWithImages:self.noteInfo successHandler:^(id result) {
        
    } errorHandler:^(NSError *error) {
        [CCStandardErrorHandler showErrorWithError:error];
    } progress:^(double finished) {
        [self.backToListTransaction perform];
        NSLog(@"%0.0lf",finished * 100);
    }];
}

@end
