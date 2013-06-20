//
//  CCStuffCreationController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransactionWithObject.h"

@interface CCStuffCreationController : CCViewController

@property (nonatomic, strong) id <CCTransactionWithObject> selectFilesFromDropboxTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesUploadTransaction;

- (IBAction)thumbDidPressed;
- (IBAction)collegeSelectionButtonDidPressed;

- (IBAction)didPressedDropboxImagesSelectionButton;
- (IBAction)didPressedImagesUploadingButton;

@end
