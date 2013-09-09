//
//  CCAddAnswerViewController.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "CCBackTransaction.h"
#import "CCTransactionWithObject.h"

@class CCQuestion;

@interface CCAddAnswerViewController : CCBaseViewController

@property (nonatomic, strong) id<CCTransaction> backTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> pdfDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesUploadTransaction;
@property (nonatomic, strong) id <CCTransaction> backToSelfController;

- (void)setQuestion:(CCQuestion *)question;

@end
