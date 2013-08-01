//
//  CCTutorialController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPhotoBrowserController.h"
#import "CCTransaction.h"

@interface CCTutorialController : CCPhotoBrowserController

@property (nonatomic, strong) id <CCTransaction> loginTransaction;

@end
