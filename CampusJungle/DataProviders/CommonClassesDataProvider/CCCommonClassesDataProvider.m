//
//  CCCommonClassesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 25.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommonClassesDataProvider.h"

@interface CCCommonClassesDataProvider()


@end

@implementation CCCommonClassesDataProvider

- (void)loadItems
{

    [self.ioc_apiProvider getCommonClassesForUserWitID:self.userID successHandler:^(RKMappingResult *result) {
        self.arrayOfItems = result.array;
        [self.targetTable reloadData];
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}


@end
