//
//  CCUserDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUserDataProvider.h"

@implementation CCUserDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_apiProvider loadUsers:self.searchQuery pageNumber:@(numberOfPage)
                                       successHandler:^(RKMappingResult *result) {
                                           successHandler(result.firstObject);
                                       } errorHandler:^(NSError *error) {
                                           [self showErrorWhileLoading:error];
                                       }];
}


@end
