//
//  CCStateSelectionConroller.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStateSelectionConroller.h"
#import "CCCommonDataSource.h"
#import "CCStatesDataProvider.h"
#import "CCStateCell.h"
#import "CCDefines.h"
#import "CCState.h"

@interface CCStateSelectionConroller ()


@property (nonatomic, strong) CCCommonDataSource *dataSource;

@end

@implementation CCStateSelectionConroller

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configTableWithProvider:[CCStatesDataProvider new] cellClass:[CCStateCell class]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.dataSource.dataProvider.searchQuery = searchText;
    [self.dataSource.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.citySelectionTransaction performWithObject:[cellObject stateID]];
}

@end
