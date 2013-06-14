//
//  CCMarketFilterDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketFilterDataSource.h"
#import "CCFilterSection.h"
#import "CCFilterSectionHeader.h"
#import "CCDefines.h"
#import "CCTableCellProtocol.h"
#import "CCClass.h"

@implementation CCMarketFilterDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataProvider.arrayOfItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.dataProvider.arrayOfItems[section] isOpen]){
      return [[(CCFilterSection *)self.dataProvider.arrayOfItems[section] classes] count];
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CCFilterSectionHeader *filterSection = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CCTableDefines.tableHeaderIdentifier];
    filterSection.section = self.dataProvider.arrayOfItems[section];
    filterSection.table = tableView;
    return filterSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:CCTableDefines.tableCellIdentifier forIndexPath:indexPath];
    CCFilterSection *section = self.dataProvider.arrayOfItems[indexPath.section];
    [cell setCellObject:section.classes[indexPath.row]];
    return (UITableViewCell *)cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCFilterSection *section = self.dataProvider.arrayOfItems[indexPath.section];
    CCClass *fakeClass = section.classes[0];
    
    if(indexPath.row != 0){
        fakeClass.isSelected = NO;
    } else {
        if(fakeClass.isSelected){
            for(CCClass *currentClass in section.classes){
                if(currentClass != fakeClass){
                    currentClass.isSelected = NO;
                }
            }
        }
    }
    
    [tableView reloadData];

}

@end
