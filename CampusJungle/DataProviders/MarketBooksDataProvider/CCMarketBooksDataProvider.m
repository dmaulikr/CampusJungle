//
//  CCMarketBooksDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketBooksDataProvider.h"
#import "CCMarketAPIProviderProtocol.h"

@interface CCMarketBooksDataProvider()

@property (nonatomic, strong) id <CCMarketAPIProviderProtocol> ioc_marketAPIProvider;

@end

@implementation CCMarketBooksDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    if(self.filters){
        [self.ioc_marketAPIProvider loadBooksNumberOfPage:[NSNumber numberWithLong:numberOfPage]
                                                  filters:self.filters
                                                    order:self.order
                                                    query:self.searchQuery
                                           successHandler:^(RKMappingResult * result) {
                                               successHandler(result.firstObject);
                                           } errorHandler:^(NSError *error) {
                                               [self showErrorWhileLoading:error];
                                           }];
    }
}

@end
