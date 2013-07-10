//
//  CCTableBasedControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCViewController.h"
#import "CCBaseDataProvider.h"
#import "CCCommonDataSource.h"

@interface CCTableBasedController : CCViewController <CCCellSelectionProtocol>

@property (nonatomic, weak) IBOutlet UITableView *mainTable;
@property (nonatomic, strong) CCCommonDataSource *dataSource;
@property (nonatomic, strong) Class dataSourceClass;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

- (void)configTableWithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass;
- (void)configTableWithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass cellReuseIdentifier:(NSString *)reuseIdentifier;

@end
