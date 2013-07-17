//
//  CCUpdateClassController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateClassController.h"
#import "CCClass.h"

@interface CCUpdateClassController : CCCreateClassController

@property (nonatomic, strong) CCClass *currentClass;
@property (nonatomic, strong) id <CCTransactionWithObject> backToClassScreenTransaction;

@end
