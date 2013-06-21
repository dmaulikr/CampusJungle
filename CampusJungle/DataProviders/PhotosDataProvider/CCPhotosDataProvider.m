//
//  CCPhotosDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 21.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPhotosDataProvider.h"

@implementation CCPhotosDataProvider

- (void)loadItems
{
    self.arrayOfItems = self.photos;
    self.totalNumber = self.arrayOfItems.count;
    [self.targetTable reloadData];
    self.isEverythingLoaded = YES;
}

@end
