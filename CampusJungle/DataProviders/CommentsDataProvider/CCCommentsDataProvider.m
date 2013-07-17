//
//  CCCommentsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommentsDataProvider.h"
#import "CCCommentsApiProviderProtocol.h"

@interface CCCommentsDataProvider ()

@property (nonatomic, strong) id<CCCommentsApiProviderProtocol> ioc_commentsApiProvider;

@end

@implementation CCCommentsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_commentsApiProvider loadCommentsForAnswerWithId:self.answerId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(NSDictionary *result) {
        NSDictionary *response = [self reverseItemsArrayInPaginationDictionary:result];
        successHandler(response);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
