//
//  CCPhotoBrowserController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPhotoBrowserController.h"
#import "CCCommonCollectionDataSource.h"
#import "CCDefines.h"
#import "CCPhotoCell.h"

@interface CCPhotoBrowserController ()<CCCellSelectionProtocol>

@property (nonatomic, strong) CCCommonCollectionDataSource *dataSource;
@property (nonatomic, weak) IBOutlet UICollectionView *photoBrowser;

@end

@implementation CCPhotoBrowserController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configCollection:self.photoBrowser WithProvider:self.dataProvider cellClass:[CCPhotoCell class]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSArray *photos = self.dataProvider.arrayOfItems;
    NSInteger index = [photos indexOfObject:self.firstPhoto];
    [self.photoBrowser setContentOffset:CGPointMake( index * self.view.frame.size.width, 0) animated:NO];
}

- (void)configCollection:(UICollectionView *)collectionView WithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    self.dataSource = [CCCommonCollectionDataSource new];
    
    [collectionView registerClass:cellCass forCellWithReuseIdentifier:CCTableDefines.collectionCellIdentifier];
    
    self.dataSource.dataProvider = provider;
    self.dataSource.dataProvider.targetTable = (UITableView *)collectionView;
    collectionView.dataSource = self.dataSource;
    collectionView.delegate = self.dataSource;
    
    self.dataSource.delegate = self;
    [provider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{

}

- (IBAction)didSwipeRight
{
    if(self.photoBrowser.contentOffset.x > 0){
        [self.photoBrowser setContentOffset:CGPointMake(self.photoBrowser.contentOffset.x -self.view.frame.size.width, 0) animated:YES];
    }
}

- (IBAction)didSwipeLeft
{
    if(self.photoBrowser.contentOffset.x + self.view.frame.size.width < self.photoBrowser.contentSize.width){
        [self.photoBrowser setContentOffset:CGPointMake(self.photoBrowser.contentOffset.x + self.view.frame.size.width, 0) animated:YES];
    }
}

- (IBAction)doneButtonDidPressed
{
    [self.closeTransaction perform];
}

@end
