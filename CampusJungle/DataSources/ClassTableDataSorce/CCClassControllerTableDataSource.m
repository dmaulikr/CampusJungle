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

#define IntervalBeforeLoading 20

static const NSInteger kDefaultCellHeight = 44;

@implementation CCClassControllerTableDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:self.dataProvider.cellReuseIdentifier];
    [cell setCellObject:self.dataProvider.arrayOfItems[indexPath.row]];
    return (UITableViewCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataProvider.cellReuseIdentifier isEqualToString:CCTableDefines.locationsCellIdentifier]) {
        CCLocation *location = [self.dataProvider.arrayOfItems objectAtIndex:indexPath.row];
        return [CCLocationCell heightForCellWithLocation:location];
    }
    return kDefaultCellHeight;
}

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
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - IntervalBeforeLoading){
        [self.dataProvider loadMoreItems];
    }
}

@end
