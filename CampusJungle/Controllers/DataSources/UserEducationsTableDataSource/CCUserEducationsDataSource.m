//
//  CCUserEducationsDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 03.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserEducationsDataSource.h"

@implementation CCUserEducationsDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.editing;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *arrayOfItems = (NSMutableArray *)self.dataProvider.arrayOfItems;
    [arrayOfItems removeObjectAtIndex:[indexPath row]];
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
}

@end
