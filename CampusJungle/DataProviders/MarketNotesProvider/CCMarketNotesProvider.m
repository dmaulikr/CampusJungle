//
//  CCMarketNotesProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketNotesProvider.h"
#import "CCMarketAPIProviderProtocol.h"

@interface  CCMarketNotesProvider()

@property (nonatomic, strong) id <CCMarketAPIProviderProtocol> ioc_marketAPIProvider;

@end

@implementation CCMarketNotesProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_marketAPIProvider loadNotesNumberOfPage:[NSNumber numberWithLong:numberOfPage]
                                              filters:self.filters
                                                order:self.order
                                                query:self.query
                                       successHandler:^(RKMappingResult * result) {
        successHandler(result.firstObject);
    } errorHandler:^(NSError *error) {
                [self showErrorWhileLoading:error];
    }];
}

@end
