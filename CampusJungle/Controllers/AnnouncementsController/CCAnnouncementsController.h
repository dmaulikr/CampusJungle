//
//  CCAnnouncementsControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBaseViewController.h"
#import "CCClass.h"
#import "CCTransactionWithObject.h"

@interface CCAnnouncementsController : CCTableBaseViewController

@property (nonatomic, strong) CCClass *currentClass;
@property (nonatomic, strong) id <CCTransactionWithObject> addAnnouncementTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> announcementDetailsTransaction;

@end
