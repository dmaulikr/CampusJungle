//
//  CCClassTableDataSorce.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassControllerTableDataSource.h"
#import "CCTableCellProtocol.h"
#import "CCLocationCell.h"

@implementation CCClassControllerTableDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.viewForSectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.viewForSectionHeader.bounds.size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - IntervalBeforeLoading){
        [self.dataProvider loadMoreItems];
    }
}

@end
