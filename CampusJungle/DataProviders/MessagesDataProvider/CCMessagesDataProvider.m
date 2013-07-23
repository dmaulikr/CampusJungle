//
//  CCMessagesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMessagesDataProvider.h"
#import "CCMessageAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"

@interface CCMessagesDataProvider()

@property (nonatomic, strong) id <CCMessageAPIProviderProtocol> ioc_messagesAPIProvider;

@end

@implementation CCMessagesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    if (self.filters){
        NSDictionary *params = self.filters.mutableCopy;
        [params setValue:@(numberOfPage) forKey:@"page_number"];
        if ([self.searchQuery length] > 0) {
            [params setValue:self.searchQuery forKey:@"keywords"];
        }
        [self.ioc_messagesAPIProvider loadMyMessagesWithParams:params successHandler:^(RKMappingResult *result) {
            successHandler(result.firstObject);
        } errorHandler:^(NSError *error) {
            [self showErrorWhileLoading:error];
        }];
    }
}

@end
