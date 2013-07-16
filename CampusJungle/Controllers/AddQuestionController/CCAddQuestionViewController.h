//
//  CCAddQuestionViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCTransactionWithObject.h"

@class CCForum;

@interface CCAddQuestionViewController : CCBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> imagesDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> pdfDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesUploadTransaction;

- (void)setForum:(CCForum *)forum;

@end
