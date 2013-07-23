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
#import "CCAvatarSelectionActionSheet.h"

#define animationDuration 0.3
#define maxNumberOfImages 6

@interface CCUploadImagesController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CCAvatarSelectionProtocol>

@property (nonatomic, weak) IBOutlet UIView *tableFooterView;
@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property (nonatomic, strong) id <CCUploadProcessManagerProtocol> ioc_uploadingManager;
@property (nonatomic, strong) CCAvatarSelectionActionSheet *avatarSelectionSheet;

@end

@implementation CCUploadImagesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Select Images";
    [self setupActionSheets];
    self.dataSourceClass = [CCImageSortingDataSource class];
    self.mainTable.editing = YES;
    self.mainTable.tableFooterView = self.tableFooterView;
    [self setButtonsTextColorInView:self.tableFooterView];
    self.dataProvider = [CCUploadingImagesDataProvider new];
    self.dataProvider.arrayOfImages = [NSMutableArray new];
    [self configTableWithProvider:self.dataProvider cellClass:[CCImageCell class]];
}

- (void)setupActionSheets
{
    self.avatarSelectionSheet = [CCAvatarSelectionActionSheet new];
    self.avatarSelectionSheet.delegate = self;
    self.avatarSelectionSheet.rejectCrop = YES;
}

- (IBAction)addImageButtonDidPressed
{
    [self.avatarSelectionSheet showWithTitle:@"Select image" takePhotoButtonTitle:@"Take a photo" takeFromGalleryButtonTitle:@"Select from gallery"];
}

- (void)didSelectAvatar:(UIImage *)avatar
{
    UIImage *fixedImage = [CCUIImageHelper fixOrientationOfImage:avatar];
    [self.dataProvider.arrayOfImages addObject:fixedImage];
    [self.dataProvider loadItems];
    [self setCustomButton];
    [self didUpdate];
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
    self.imagesUploading(self.dataProvider.arrayOfImages);
}

@end
