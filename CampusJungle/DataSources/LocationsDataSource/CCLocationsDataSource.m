//
//  CCLocationsDataSource.m
//  CampusJungle
//
//  Created by Yury Grinenko on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocationsDataSource.h"
#import "CCLocation.h"
#import "CCLocationCell.h"
#import "CCTableCellProtocol.h"

@implementation CCLocationsDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <CCTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:self.currentCellReuseIdentifier];
    [cell setCellObject:self.dataProvider.arrayOfItems[indexPath.row]];
    return (UITableViewCell *)cell;
}

@end
