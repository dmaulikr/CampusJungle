//
//  CCClassLocationsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassLocationsDataProvider.h"
#import "CCLocationsApiProviderProtocol.h"
#import "CCLocationDataProviderDelegate.h"

@interface CCClassLocationsDataProvider ()

@property (nonatomic, strong) id<CCLocationsApiProviderProtocol> ioc_locationsApiProvider;
@property (nonatomic, weak) id<CCLocationDataProviderDelegate> delegate;

@end

@implementation CCClassLocationsDataProvider

- (id)initWithDelegate:(id<CCLocationDataProviderDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    __weak CCClassLocationsDataProvider *weakSelf = self;
    [self.ioc_locationsApiProvider loadLocationsForClassWithId:self.classId pageNumber:numberOfPage successHandler:^(RKMappingResult *result) {
        successHandler(result);
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didLoadLocations:)]) {
            [weakSelf.delegate didLoadLocations:[result valueForKey:@"items"]];
        }
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
