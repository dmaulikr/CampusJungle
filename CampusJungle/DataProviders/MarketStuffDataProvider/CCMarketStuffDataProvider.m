//
//  CCMarketStuffDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketStuffDataProvider.h"

#import "CCMarketAPIProviderProtocol.h"

@interface  CCMarketStuffDataProvider()

@property (nonatomic, strong) id <CCMarketAPIProviderProtocol> ioc_marketAPIProvider;

@end

@implementation CCMarketStuffDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    if(self.filters){
        [self.ioc_marketAPIProvider loadStuffNumberOfPage:[NSNumber numberWithLong:numberOfPage]
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
