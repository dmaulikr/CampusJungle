//
//  CCAddAnnouncementController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCClass.h"
#import "CCTransaction.h"

@interface CCAddAnnouncementController : CCBaseViewController

@property (nonatomic, strong) CCClass *currentClass;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;

@end
