//
//  CCCommonCollectionDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommonCollectionDataSource.h"
#import "CCDefines.h"
#import "CCTableCellProtocol.h"

#define IntervalBeforeLoading 40

@implementation CCCommonCollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataProvider.arrayOfItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [collectionView dequeueReusableCellWithReuseIdentifier:CCTableDefines.collectionCellIdentifier forIndexPath:indexPath];
    [cell setCellObject:self.dataProvider.arrayOfItems[indexPath.row]];
    
    return (UICollectionViewCell *)cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectedCellWithObject:self.dataProvider.arrayOfItems[indexPath.row]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.frame.size.width - IntervalBeforeLoading){
        [self.dataProvider loadMoreItems];
    }
}

@end
