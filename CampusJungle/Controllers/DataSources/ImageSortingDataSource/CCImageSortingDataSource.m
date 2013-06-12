//
//  CCImageSortingDataSource.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImageSortingDataSource.h"
#import "CCDropboxFileInfo.h"

@implementation CCImageSortingDataSource

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *arrayOfItems = (NSMutableArray *)self.dataProvider.arrayOfItems;
    CCDropboxFileInfo *fileInfo = self.dataProvider.arrayOfItems[indexPath.row];
    if([fileInfo respondsToSelector:@selector(setIsSelected:)]){
        fileInfo.isSelected = NO;
    }
    [arrayOfItems removeObjectAtIndex:[indexPath row]];
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
    [self.delegate performSelector:@selector(didUpdate)];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray *arrayOfItems = (NSMutableArray *)self.dataProvider.arrayOfItems;
    
    id movedObject = arrayOfItems[fromIndexPath.row];
    [arrayOfItems removeObjectAtIndex:fromIndexPath.row];
    [arrayOfItems insertObject:movedObject atIndex:toIndexPath.row];
    
    [tableView reloadData];
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
