//
//  CCDialogsDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 16.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDialogsDataProvider.h"

#import "CCDialogsAPIProviderProtocol.h"

@interface CCDialogsDataProvider()

@property (nonatomic, strong) id <CCDialogsAPIProviderProtocol> ioc_dialogsDataProvider;

@end

@implementation CCDialogsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_dialogsDataProvider loadMyDialogsPageNumber:(int)numberOfPage successHandler:^(RKMappingResult *result) {
        successHandler(result.firstObject);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}


@end
