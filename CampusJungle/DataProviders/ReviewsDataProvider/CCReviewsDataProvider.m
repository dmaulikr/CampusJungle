//
//  CCReviewsDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCReviewsDataProvider.h"

@implementation CCReviewsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_apiProvider loadReviewsForUser:self.userID successHandler:^(RKMappingResult *result) {
        successHandler(result.firstObject);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
