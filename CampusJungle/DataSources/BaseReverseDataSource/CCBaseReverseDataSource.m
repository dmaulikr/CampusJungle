//
//  CCBaseReverseDataSource.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseReverseDataSource.h"
#import "CCTableCellProtocol.h"
#import "CCLoadPreviousItemsSectionHeader.h"

@interface CCBaseReverseDataSource ()

@property (nonatomic, strong) CCLoadPreviousItemsSectionHeader *headerView;

@end

@implementation CCBaseReverseDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:self.currentCellReuseIdentifier];
    [cell setCellObject:self.dataProvider.arrayOfItems[indexPath.row]];
    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [cell performSelector:@selector(setDelegate:) withObject:self.delegate];
    }
    return (UITableViewCell *)cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataProvider.isEverythingLoaded) {
        return nil;
    }
    if (!self.headerView) {
        [self createHeaderView];
    }
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataProvider.isEverythingLoaded) {
        return 0;
    }
    if (!self.headerView) {
        [self createHeaderView];
    }
    return self.headerView.bounds.size.height;
}

- (void)createHeaderView
{
    self.headerView = [[CCLoadPreviousItemsSectionHeader alloc] initWithTitle:CCHeaderViewsTitles.answersHeaderViewTitle target:self action:@selector(loadPreviousAnswersButtonDidPressed:)];
}

- (void)loadPreviousAnswersButtonDidPressed:(id)sender
{
    [self.dataProvider loadMoreItems];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
