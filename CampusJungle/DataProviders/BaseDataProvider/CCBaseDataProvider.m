//
//  CCBaseDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseDataProvider.h"
#import "CCStandardErrorHandler.h"

@implementation CCBaseDataProvider

- (void)showErrorWhileLoading:(NSError *)error
{
    [CCStandardErrorHandler showErrorWithError:error];
}

- (BOOL)isEmpty
{
    return !self.arrayOfItems.count;
}

- (void)loadMoreItems{}

- (void)deleteItem:(id)item
{
    NSInteger itemIndex = [self.arrayOfItems indexOfObject:item];
    NSIndexPath *itemIndexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
    
    NSMutableArray *mutableArrayOfItems = [self.arrayOfItems mutableCopy];
    [mutableArrayOfItems removeObject:item];
    self.arrayOfItems = [NSArray arrayWithArray:mutableArrayOfItems];
    [self.targetTable deleteRowsAtIndexPaths:@[itemIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
