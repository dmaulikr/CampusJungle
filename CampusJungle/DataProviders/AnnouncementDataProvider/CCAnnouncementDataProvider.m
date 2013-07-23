//
//  CCAnnouncementDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnnouncementDataProvider.h"
#import "CCAnnouncementAPIProviderProtocol.h"

@interface CCAnnouncementDataProvider()

@property (nonatomic, strong) id <CCAnnouncementAPIProviderProtocol> ioc_annoucementAPIProvider;

@end

@implementation CCAnnouncementDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_annoucementAPIProvider loadAnnouncementsClassID:self.classID
                                                 filterString:self.searchQuery
                                                   pageNumber:(int)numberOfPage
                                               successHandler:^(RKMappingResult *result) {
                                                   successHandler(result.firstObject);
                                               } errorHandler:^(NSError *error) {
                                                   [self showErrorWhileLoading:error];
                                               }];
}

@end
