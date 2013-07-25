//
//  CCStuffCollectionViewDataSource.m
//  CampusJungle
//
//  Created by Yury Grinenko on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStuffCollectionViewDataSource.h"
#import "CCStuffHeader.h"

@interface CCStuffCollectionViewDataSource ()

@property (nonatomic, strong) CCStuffHeader *supplementaryView;
@property (nonatomic, strong) CCStuff *stuff;

@end

@implementation CCStuffCollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (!self.supplementaryView) {
        [self createSupplementaryView];
    }
    return self.supplementaryView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (!self.supplementaryView) {
        [self createSupplementaryView];
    }
    return self.supplementaryView.bounds.size;
}

- (void)createSupplementaryView
{
    self.supplementaryView = [CCStuffHeader new];
    [self.supplementaryView setStuff:self.stuff];
}

- (void)setStuffHeaderDelegate:(id<CCStuffHeaderDelegate>)delegate
{
    if (!self.supplementaryView) {
        [self createSupplementaryView];
    }
    [self.supplementaryView setDelegate:delegate];
}

@end
