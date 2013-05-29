//
//  CCStatesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStatesDataProvider.h"

@implementation CCStatesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_apiProvider loadStatesNumberOfPage:[NSNumber numberWithLong:numberOfPage] query:self.searchQuery successHandler:^(RKMappingResult *result) {
        
        successHandler(result.firstObject);
        
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
