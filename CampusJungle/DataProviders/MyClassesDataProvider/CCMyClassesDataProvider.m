//
//  CCMyClassesDataProvider.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMyClassesDataProvider.h"

@implementation CCMyClassesDataProvider

- (void) loadItems
{
    self.arrayOfItems = self.arrayOfMyClasses;
    self.totalNumber = self.arrayOfMyClasses.count;
}

- (void)loadMoreItems
{
    
}


@end
