//
//  CCAdsDataSource.m
//  CampusJungle
//
//  Created by Yury Grinenko on 05.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAdsDataSource.h"

@implementation CCAdsDataSource

 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

@end
