//
//  CCPhotoBrowserController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCBaseDataProvider.h"
#import "CCPhoto.h"
#import "CCTransaction.h"

@interface CCPhotoBrowserController : CCViewController

@property (nonatomic, strong) CCBaseDataProvider *dataProvider;
@property (nonatomic, strong) CCPhoto *firstPhoto;
@property (nonatomic, strong) id <CCTransaction> closeTransaction;

- (IBAction)didSwipeRight;
- (IBAction)didSwipeLeft;
- (IBAction)doneButtonDidPressed;

@end
