//
//  CCTableBasedControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCDefines.h"

@interface CCTableBasedController ()

@property (nonatomic, strong) Class dataSourceClass;

@end

@implementation CCTableBasedController

- (void)configTableWithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    [self.mainTable registerClass:cellCass forCellReuseIdentifier:CCTableDefines.tableCellIdentifier];
    
    CCCommonDataSource *dataSource = [CCCommonDataSource new];
    dataSource.dataProvider = provider;
    dataSource.dataProvider.targetTable = self.mainTable;
    self.mainTable.dataSource = dataSource;
    self.mainTable.delegate = dataSource;
    self.dataSource = dataSource;
    self.dataSource.delegate = self;
    [dataSource.dataProvider loadItems];
}

- (void)didSelectedCellWithObject:(id)cellObject
{
    
}

@end
