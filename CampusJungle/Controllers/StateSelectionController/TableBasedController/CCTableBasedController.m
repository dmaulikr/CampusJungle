//
//  CCTableBasedControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTableBasedController.h"
#import "CCDefines.h"

@interface CCTableBasedController ()<UISearchBarDelegate>

@end

@implementation CCTableBasedController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSearchBar];
    self.tapRecognizer.enabled = NO;
}

- (void)configSearchBar
{
    [self setNilButtonBackgroundForView:self.searchBar];
}

- (void)setNilButtonBackgroundForView:(UIView *)view
{
    for(UIButton *button in view.subviews){
        if([button isKindOfClass:[UIButton class]]){
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            [button setBackgroundImage:nil forState:UIControlStateHighlighted];
        } else {
            [self setNilButtonBackgroundForView:button];
        }
    }
}

- (void)configTableWithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass
{
    [self configTableWithProvider:provider cellClass:cellCass cellReuseIdentifier:CCTableDefines.tableCellIdentifier];
}

- (void)configTableWithProvider:(CCBaseDataProvider *)provider cellClass:(Class)cellCass cellReuseIdentifier:(NSString *)reuseIdentifier
{
    [self.mainTable registerClass:cellCass forCellReuseIdentifier:reuseIdentifier];
    CCCommonDataSource *dataSource;
    self.mainTable.backgroundColor = [UIColor clearColor];
    if(self.dataSource){
        dataSource = self.dataSource;
    } else if (self.dataSourceClass){
        dataSource = [self.dataSourceClass new];
    } else {
        dataSource = [CCCommonDataSource new];
    }
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self performSelector:@selector(configSearchBar) withObject:nil afterDelay:0.01];
    self.dataSource.dataProvider.searchQuery = searchText;
    self.lastSearchPressTime = [NSDate date];
    
    double delayInSeconds = 1.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if([[NSDate date] timeIntervalSinceDate:self.lastSearchPressTime] >= 1){
            [self.dataSource.dataProvider loadItems];
        }
    });
}

@end
