//
//  CCEducationsDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCEducationsDataProvider.h"

@implementation CCEducationsDataProvider

- (void) loadItems
{
    self.arrayOfItems = self.arrayOfEducations;
    [self.targetTable reloadData];
    self.isEverythingLoaded = YES;
    self.totalNumber = self.arrayOfItems.count;
}

- (void) loadMoreItems
{

}

@end
