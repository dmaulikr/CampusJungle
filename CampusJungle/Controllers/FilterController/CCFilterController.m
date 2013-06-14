//
//  CCFilterController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCFilterController.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCFiltersDataProvider.h"
#import "CCMarketFilterDataSource.h"
#import "CCOrdinaryCell.h"
#import "CCFilterSectionHeader.h"
#import "CCDefines.h"
#import "CCMarketFilterClassesCell.h"

@interface CCFilterController ()

@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesAPIProvider;

@end

@implementation CCFilterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CCFiltersDataProvider *dataProvider = [CCFiltersDataProvider new];
    self.dataSourceClass = [CCMarketFilterDataSource class];
    [self configTableWithProvider:dataProvider cellClass:[CCMarketFilterClassesCell class]];
    [self.mainTable registerClass:[CCFilterSectionHeader class] forHeaderFooterViewReuseIdentifier:CCTableDefines.tableHeaderIdentifier];
}



@end