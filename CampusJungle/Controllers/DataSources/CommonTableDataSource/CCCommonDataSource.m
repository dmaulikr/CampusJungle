//
//  CCCommonDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommonDataSource.h"
#import "CCTableCellProtocol.h"
#import "CCDefines.h"

#define IntervalBeforeLoading 20

@implementation CCCommonDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataProvider.arrayOfItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:CCTableDefines.tableCellIdentifier];
    [cell setCellObject:self.dataProvider.arrayOfItems[indexPath.row]];
    return (UITableViewCell *)cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[(UIViewController *)self.delegate view] endEditing:YES];
    if(scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height - IntervalBeforeLoading){
        [self.dataProvider loadMoreItems];
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectedCellWithObject:self.dataProvider.arrayOfItems[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(isNeedToLeftSelected)] && ![self.delegate isNeedToLeftSelected]){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
