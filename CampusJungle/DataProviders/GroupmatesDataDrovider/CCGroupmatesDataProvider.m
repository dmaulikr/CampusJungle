//
//  CCGroupmatesDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupmatesDataProvider.h"
#import "CCGroupsApiProviderProtocol.h"

@interface CCGroupmatesDataProvider ()

@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;

@end

@implementation CCGroupmatesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_groupsApiProvider loadMembersOfGroup:self.group filterString:self.searchQuery pageNumber:@(numberOfPage) successHandler:^(RKMappingResult *result) {
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
