//
//  CCSideMenuDataSource.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuDataSource.h"
#import "CCTableCellProtocol.h"

#import "CCClass.h"

#import "CCSideMenuClassCell.h"
#import "CCSideMenuItemCell.h"
#import "CCSideMenuSectionHeader.h"

#import "CCSideMenuDataSourceHelper.h"

#define CELLS_CLASSES @[[CCSideMenuItemCell class], [CCSideMenuClassCell class]]
#define CELLS_REUSE_IDENTIFIERS @[@"MenuItemCell", @"MenuClassCell"]

@interface CCSideMenuDataSource ()

@property (nonatomic, strong) NSArray *sectionsArray;
@property (nonatomic, weak) id<CCSideMenuDelegate> delegate;

@end

@implementation CCSideMenuDataSource

- (id)initWithDelegate:(id<CCSideMenuDelegate>)delegate sectionsArray:(NSArray *)sectionsArray
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.sectionsArray = [CCSideMenuDataSourceHelper menuSectionsArrayWithEducationsArray:sectionsArray];
    }
    return self;
}

- (NSArray *)dataArrayForSectionAtIndex:(NSInteger)sectionIndex
{
    return [[self.sectionsArray objectAtIndex:sectionIndex] valueForKey:@"items"];
}

- (NSString *)nameForSectionAtIndex:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        return nil;
    }
    return [[self.sectionsArray objectAtIndex:sectionIndex] valueForKey:@"name"];
}

- (NSString *)nameOfClassAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return nil;
    }
    NSArray *classesInSection = [self dataArrayForSectionAtIndex:indexPath.section];
    return [(CCClass *)[classesInSection objectAtIndex:indexPath.row] name];
}

- (id)objectForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self dataArrayForSectionAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (Class)cellClassAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        return [CELLS_CLASSES objectAtIndex:1];
    }
    return [CELLS_CLASSES objectAtIndex:0];
}

- (NSString *)cellReuseIdentifierAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        return [CELLS_REUSE_IDENTIFIERS objectAtIndex:1];
    }
    return [CELLS_REUSE_IDENTIFIERS objectAtIndex:0];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self dataArrayForSectionAtIndex:section].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellClass = [self cellClassAtIndexPath:indexPath];
    NSString *reusableIdentifier = [self cellReuseIdentifierAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
    }
    id objectForCell = [self objectForCellAtIndexPath:indexPath];
    [cell performSelector:@selector(fillWithObject:) withObject:objectForCell];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    NSString *sectionHeaderText = [self nameForSectionAtIndex:section];
    return [CCSideMenuSectionHeader heightForHeaderWithText:sectionHeaderText];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    NSString *sectionHeaderText = [self nameForSectionAtIndex:section];
    return [[CCSideMenuSectionHeader alloc] initWithText:sectionHeaderText delegate:self.delegate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id objectForCell = [self objectForCellAtIndexPath:indexPath];
    if ([objectForCell isKindOfClass:[NSString class]]) {
        NSString *cellTitle = (NSString *)objectForCell;
        if ([cellTitle isEqualToString:CCSideMenuTitles.newsFeed]) {
            [self.delegate showNewsFeed];
        }
        else {
            [self.delegate showMarketPlace];
        }
    }
    else {
        [self.delegate showDetailsOfClass:objectForCell];
    }
}

@end
