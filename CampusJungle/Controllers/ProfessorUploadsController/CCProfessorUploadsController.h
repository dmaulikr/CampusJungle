//
//  CCProfessorUploadsController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCTransactionWithObject.h"
#import "CCClass.h"

@interface CCProfessorUploadsController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> addUploadsTransaction;
@property (nonatomic, strong) CCClass *currentClass;
@property (nonatomic, strong) id<CCTransactionWithObject> viewAttachmentTransaction;

@end
