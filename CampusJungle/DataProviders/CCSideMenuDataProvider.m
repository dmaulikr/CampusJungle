//
//  CCSideMenuDataProvider.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/30/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuDataProvider.h"

@implementation CCSideMenuDataProvider

- (void) loadItems
{
    self.arrayOfItems = self.arrayOfMenuItems;
    self.totalNumber = self.arrayOfItems.count;
}


@end
