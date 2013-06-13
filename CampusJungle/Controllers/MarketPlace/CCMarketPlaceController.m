//
//  CCMarketPlaceController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketPlaceController.h"
#import "CCMarketNotesProvider.h"
#import "CCDefines.h"
#import "CCCommonCollectionDataSource.h"
#import "CCNotesCollectionCell.h"

@interface CCMarketPlaceController ()<CCCellSelectionProtocol>

@property (nonatomic, weak) IBOutlet UICollectionView *topNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestStuffCollectionView;

@property (nonatomic, strong) NSArray *arrayOfFilters;
@property (nonatomic, strong) CCMarketNotesProvider *marketLatestNotesProvider;
@property (nonatomic, strong) CCMarketNotesProvider *marketTopNotesProvider;
@property (nonatomic, strong) NSMutableArray *arrayOfDataSources;

@end

@implementation CCMarketPlaceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayOfDataSources = [NSMutableArray new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStyleBordered target:self action:@selector(applyFilters)];
    self.marketLatestNotesProvider = [CCMarketNotesProvider new];
    self.marketLatestNotesProvider.filters = @{
                                               @"colleges_ids" : @[@20429]
                                               };
    self.marketLatestNotesProvider.order = @"date";
    
    
    [self configCollection:self.topNotesCollectionView WithProvider:self.marketLatestNotesProvider cellClass:[CCNotesCollectionCell class]];
    
    self.marketTopNotesProvider = [CCMarketNotesProvider new];
    self.marketTopNotesProvider.filters = self.marketLatestNotesProvider.filters;
    self.marketTopNotesProvider.order = @"sales";
    
    [self configCollection:self.latestNotesCollectionView WithProvider:self.marketTopNotesProvider cellClass:[CCNotesCollectionCell class]];
}

- (void)applyFilters
{
    [self.filtersScreenTransaction performWithObject:self.arrayOfFilters];
}

- (void)configCollection:(UICollectionView *)collectionView WithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    [collectionView registerClass:cellCass forCellWithReuseIdentifier:CCTableDefines.collectionCellIdentifier];
    CCCommonCollectionDataSource *dataSource = [CCCommonCollectionDataSource new];

    dataSource.dataProvider = provider;
    dataSource.dataProvider.targetTable = collectionView;
    collectionView.dataSource = dataSource;
    collectionView.delegate = dataSource;
    [self.arrayOfDataSources addObject:dataSource];
    dataSource.delegate = self;
    [dataSource.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{


}

@end
