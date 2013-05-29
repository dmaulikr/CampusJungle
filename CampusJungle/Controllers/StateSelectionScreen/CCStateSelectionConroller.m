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

@interface CCStateSelectionConroller ()

@property (nonatomic, weak) IBOutlet UITableView *statesTable;
@property (nonatomic, strong) CCCommonDataSource *dataSource;

@end

@implementation CCStateSelectionConroller

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self.statesTable registerClass:[CCStateCell class] forCellReuseIdentifier:CCTableDefines.tableCellIdentifier];
    CCCommonDataSource *dataSource = [CCCommonDataSource new];
    dataSource.dataProvider = [CCStatesDataProvider new];
    dataSource.dataProvider.targetTable = self.statesTable;
    self.statesTable.dataSource = dataSource;
    self.statesTable.delegate = dataSource;
    self.dataSource = dataSource;
    [dataSource.dataProvider loadItems];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.dataSource.dataProvider.searchQuery = searchText;
    [self.dataSource.dataProvider loadItems];
}

@end
