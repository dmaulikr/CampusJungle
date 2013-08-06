//
//  CCAddBookViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCAddBookViewController : CCBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> selectFilesFromDropboxTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesUploadTransaction;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;
@property (nonatomic, strong) id <CCTransaction> backToSlefTransaction;

- (IBAction)thumbDidPressed;
- (IBAction)collegeSelectionButtonDidPressed;

- (IBAction)didPressedDropboxImagesSelectionButton;
- (IBAction)didPressedImagesUploadingButton;

@end
