//
//  CCGroupsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupsDataProvider.h"
#import "CCGroupsApiProviderProtocol.h"

@interface CCGroupsDataProvider ()

@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;

@end

@implementation CCGroupsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_groupsApiProvider loadGroupsForClassWithId:self.classId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(RKMappingResult *result) {
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];

}

@end
