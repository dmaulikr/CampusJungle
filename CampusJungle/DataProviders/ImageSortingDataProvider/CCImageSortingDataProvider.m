//
//  CCImageSortingDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCImageSortingDataProvider.h"

@implementation CCImageSortingDataProvider

- (void)loadItems
{
    self.arrayOfItems = self.arrayOfDropboxImages;
    self.totalNumber = self.arrayOfItems.count;
    [self.targetTable reloadData];
    self.isEverythingLoaded = YES;
}

@end
