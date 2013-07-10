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

@implementation CCLocationsDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    CCLocation *location = [self.dataProvider.arrayOfItems objectAtIndex:indexPath.row];
    return [CCLocationCell heightForCellWithLocation:location];
}

@end
