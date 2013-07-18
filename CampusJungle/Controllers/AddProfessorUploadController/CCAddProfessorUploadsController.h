//
//  CCAddProfessorUploadsController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCClass.h"
#import "CCTransaction.h"
#import "CCTransactionWithObject.h"

@interface CCAddProfessorUploadsController : CCBaseViewController

@property (nonatomic, strong) CCClass *currentClass;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> pdfDropboxUploadTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> imagesUploadTransaction;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;

@end
