//
//  CCGroupmatesDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupmatesDataProvider.h"
#import "CCGroupsApiProviderProtocol.h"

@interface CCGroupmatesDataProvider ()

@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;
@property (nonatomic, assign) NSInteger itemsPerPage;
@property (nonatomic, assign) BOOL needToSelectAllItems;

@end

@implementation CCGroupmatesDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    __weak CCGroupmatesDataProvider *weakSelf = self;
    [self.ioc_groupsApiProvider loadMembersOfGroup:self.group filterString:self.searchQuery pageNumber:@(numberOfPage) itemsPerPage:@(self.itemsPerPage) successHandler:^(NSDictionary *result) {
        if (weakSelf.needToSelectAllItems) {
            result = [self selectItemsInPaginationDictionary:result];
        }
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

- (NSDictionary *)selectItemsInPaginationDictionary:(NSDictionary *)sourceDictionary
{
    NSMutableDictionary *mutableResponse = [sourceDictionary mutableCopy];
    NSArray *arrayOfItems = mutableResponse[CCResponseKeys.items];
    for (id item in arrayOfItems) {
        if ([item respondsToSelector:@selector(setIsSelected:)]) {
            [item setIsSelected:YES];
        }
    }
    [mutableResponse setValue:arrayOfItems forKey:CCResponseKeys.items];
    return mutableResponse;
}

@end
