//
//  CCClassesDataProvider.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassesDataProvider.h"

@implementation CCClassesDataProvider

- (void) loadItems
{
    self.arrayOfItems = self.arrayOfClasses;
    self.totalNumber = self.arrayOfItems.count;
    [self.targetTable reloadData];
    self.isEverythingLoaded = YES;
}

- (void)loadMoreItems
{
    
}

@end
