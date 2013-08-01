//
//  CCPhotoBrowserController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCBaseDataProvider.h"
#import "CCPhoto.h"
#import "CCTransaction.h"

@interface CCPhotoBrowserController : CCBaseViewController

@property (nonatomic, strong) CCBaseDataProvider *dataProvider;
@property (nonatomic, strong) CCPhoto *firstPhoto;
@property (nonatomic, strong) id <CCTransaction> closeTransaction;
@property (nonatomic, weak) IBOutlet UICollectionView *photoBrowser;

- (IBAction)didSwipeRight;
- (IBAction)didSwipeLeft;
- (IBAction)doneButtonDidPressed;

- (void)configCollection:(UICollectionView *)collectionView WithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass;

@end
