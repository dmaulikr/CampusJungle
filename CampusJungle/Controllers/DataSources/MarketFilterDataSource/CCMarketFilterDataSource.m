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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CCFilterSectionHeader *filterSection = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CCTableDefines.tableHeaderIdentifier];
    filterSection.section = self.dataProvider.arrayOfItems[section];
    filterSection.table = tableView;
    return filterSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}

@end
