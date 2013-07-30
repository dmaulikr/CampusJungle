//
//  CCInboxAppInvitesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInboxAppInvitesDataProvider.h"
#import "CCAppInviteApiProviderProtocol.h"

@interface CCInboxAppInvitesDataProvider()

@property (nonatomic, strong) id <CCAppInviteApiProviderProtocol> ioc_appInvitesAPIProvider;

@end

@implementation CCInboxAppInvitesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_appInvitesAPIProvider loadAppInvitesWithPageNumber:(NSInteger)numberOfPage successHandler:^(id result) {
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
