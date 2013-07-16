//
//  CCForumsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCForumsDataProvider.h"
#import "CCForumsApiProviderProtocol.h"

@interface CCForumsDataProvider ()

@property (nonatomic, strong) id<CCForumsApiProviderProtocol> ioc_forumsApiProvider;

@end

@implementation CCForumsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_forumsApiProvider loadForumsForClassWithId:self.classId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(RKMappingResult *result) {
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}
@end
