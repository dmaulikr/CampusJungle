//
//  CCMarketPlaceController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketPlaceController.h"

@interface CCMarketPlaceController ()

@property (nonatomic, weak) IBOutlet UICollectionView *topNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestNotesCollectionView;
@property (nonatomic, weak) IBOutlet UICollectionView *latestStuffCollectionView;
@property (nonatomic, strong) NSArray *arrayOfFilters;

@end

@implementation CCMarketPlaceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStyleBordered target:self action:@selector(applyFilters)];
}

- (void)applyFilters
{
    [self.filtersScreenTransaction performWithObject:self.arrayOfFilters];
}

@end
