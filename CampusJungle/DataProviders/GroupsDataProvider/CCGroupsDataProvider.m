//
//  CCGroupsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupsDataProvider.h"

@implementation CCGroupsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    successHandler(@{@"count" : @(0), @"items" : [NSArray array]});
}

@end
