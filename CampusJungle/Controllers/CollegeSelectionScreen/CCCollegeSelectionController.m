//
//  CCCollegeSelectionController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSelectionController.h"
#import "CCCollege.h"
#import "CCCollegeSelectionDataProvider.h"
#import "CCCollegeSelectionCell.h"

@interface CCCollegeSelectionController ()

@end

@implementation CCCollegeSelectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CCCollegeSelectionDataProvider *collegesProvider = [CCCollegeSelectionDataProvider new];
    collegesProvider.cityID = self.cityID;
    
    [self configTableWithProvider:collegesProvider cellClass:[CCCollegeSelectionCell class]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.dataSource.dataProvider.searchQuery = searchText;
    [self.dataSource.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    [self.educationTransaction performWithObject:[(CCCollege *)cellObject collegeID]];
}

@end
