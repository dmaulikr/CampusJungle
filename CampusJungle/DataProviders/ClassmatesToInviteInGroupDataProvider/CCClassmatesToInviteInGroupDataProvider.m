//
//  CCClassmatesToInviteInGroupDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassmatesToInviteInGroupDataProvider.h"
#import "CCGroupsApiProviderProtocol.h"
#import "CCGroup.h"

@interface CCClassmatesToInviteInGroupDataProvider ()

@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;
@property (nonatomic, strong) CCGroup *group;

@end

@implementation CCClassmatesToInviteInGroupDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_groupsApiProvider loadClassmatesToInviteInGroup:self.group pageNumber:@(numberOfPage) successHandler:^(RKMappingResult *result) {
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];    
}

@end
