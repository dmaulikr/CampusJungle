//
//  CCAdsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 02.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAdsDataProvider.h"
#import "CCAdsApiProviderProtocol.h"

@interface CCAdsDataProvider ()

@property (nonatomic, strong) id<CCAdsApiProviderProtocol> ioc_adsApiProvider;
@property (nonatomic, strong) NSString *classId;

@end

@implementation CCAdsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_adsApiProvider loadAdsInClassWithId:self.classId pageNumber:numberOfPage successHandler:^(RKMappingResult *result) {
        successHandler(result.firstObject);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}


@end
