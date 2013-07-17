//
//  CCAnswersDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswersDataProvider.h"
#import "CCAnswersApiProviderProtocol.h"

@interface CCAnswersDataProvider ()

@property (nonatomic, strong) id<CCAnswersApiProviderProtocol> ioc_answersApiProvider;

@end

@implementation CCAnswersDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_answersApiProvider loadAnswersForQuestionWithId:self.questionId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(NSDictionary *result) {
        NSDictionary *response = [self reverseItemsArrayInPaginationDictionary:result];
        successHandler(response);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
