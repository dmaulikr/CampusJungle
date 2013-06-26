//
//  CCCollegeSearchDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSearchDataProvider.h"

@implementation CCCollegeSearchDataProvider
- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_apiProvider loadCollegesNumberOfPage:[NSNumber numberWithLong:numberOfPage] query:self.searchQuery successHandler:^(RKMappingResult *result) {
    
        successHandler(result.firstObject);
    
    } errorHandler:^(NSError *error) {
    [self showErrorWhileLoading:error];
    }];
}

@end
