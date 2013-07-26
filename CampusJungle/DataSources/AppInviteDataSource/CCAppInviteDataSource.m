//
//  CCAppInviteDataSource.m
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppInviteDataSource.h"
#import "CCAddressBookRecord.h"
#import "CCAddressBookService.h"

#import "CCAddressBookHeader.h"
#import "CCTableCellProtocol.h"
#import "CCAddressBookRecordCell.h"

@interface CCAppInviteDataSource ()

@end

@implementation CCAppInviteDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataProvider.addressBookRecordsWithSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sourceItemsArray = [self.dataProvider.addressBookRecordsWithSections objectAtIndex:section];
    return [sourceItemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:self.currentCellReuseIdentifier];
    
    NSArray *sourceItemsArray = [self.dataProvider.addressBookRecordsWithSections objectAtIndex:indexPath.section];
    id cellObject = [sourceItemsArray objectAtIndex:indexPath.row];
    
    [cell setCellObject:cellObject];
    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [cell performSelector:@selector(setDelegate:) withObject:self.delegate];
    }
    return (UITableViewCell *)cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCAddressBookRecordCell *cell = (CCAddressBookRecordCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (self.dataProvider.mode == 0) {
        [cell userTapsToSelectEmails];
    }
    else {
        [cell userTapsToSelectPhoneNumbers];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *text = [self.dataProvider.firstLetters objectAtIndex:section];
    return [[CCAddressBookHeader alloc] initWithText:text];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [CCAddressBookHeader height];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.dataProvider.firstLetters;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.dataProvider.firstLetters indexOfObject:title];
}

@end
