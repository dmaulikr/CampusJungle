//
//  CCCitySelectionScreenViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCitySelectionController.h"
#import "CCCityCell.h"
#import "CCCitiesDataProvider.h"

@interface CCCitySelectionController ()

@end

@implementation CCCitySelectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CCCitiesDataProvider *citiesProvider = [CCCitiesDataProvider new];
    citiesProvider.stateID = self.stateID;

    [self configTableWithProvider:citiesProvider cellClass:[CCCityCell class]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.dataSource.dataProvider.searchQuery = searchText;
    [self.dataSource.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    //[self.citySelectionTransaction performWithObject:[cellObject stateID]];
}

@end
