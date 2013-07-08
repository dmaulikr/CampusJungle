//
//  CCOffersDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCOffersDataProvider.h"
#import "CCStuffAPIProviderProtocol.h"

@interface CCOffersDataProvider()

@property (nonatomic, strong) id <CCStuffAPIProviderProtocol> ioc_stuffAPIProvider;

@end

@implementation CCOffersDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_stuffAPIProvider loadOffersNumberOfPage:[NSNumber numberWithLong:numberOfPage]
                                       successHandler:^(RKMappingResult *result) {
                                           successHandler(result.firstObject);
                                       } errorHandler:^(NSError *error) {
                                           [self showErrorWhileLoading:error];
                                       }];
}

@end
