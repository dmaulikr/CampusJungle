//
//  CCGroupInvitesDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 24.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupInvitesDataProvider.h"
#import "CCGroupInvitesApiProviderProtocol.h"

@interface CCGroupInvitesDataProvider ()

@property (nonatomic, strong) id<CCGroupInvitesApiProviderProtocol> ioc_groupInvitesApiProvider;

@end

@implementation CCGroupInvitesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_groupInvitesApiProvider loadGroupInvitesPageNumber:@(numberOfPage) successHandler:^(RKMappingResult *result) {
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
