//
//  CCSelectFiltersTranaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectFiltersTranaction.h"
#import "CCFilterController.h"
#import "CCApplyFiltersTransaction.h"

@implementation CCSelectFiltersTranaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCFilterController *filterController = [CCFilterController new];
    
    CCApplyFiltersTransaction *applyFiltersTransaction = [CCApplyFiltersTransaction new];
    applyFiltersTransaction.navigation = self.navigation;
    applyFiltersTransaction.marketPlace = object;
    
    filterController.backToMarketTRansaction = applyFiltersTransaction;
    filterController.oldFilters = [[object filters] copy];
    
    [self.navigation pushViewController:filterController animated:YES];
}

@end
