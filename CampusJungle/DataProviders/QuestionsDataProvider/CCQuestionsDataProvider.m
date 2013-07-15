//
//  CCQuestionsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestionsDataProvider.h"
#import "CCQuestionsApiProviderProtocol.h"

@interface CCQuestionsDataProvider ()

@property (nonatomic, strong) id<CCQuestionsApiProviderProtocol> ioc_questionsApiProvider;

@end

@implementation CCQuestionsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    [self.ioc_questionsApiProvider loadQuestionsForForumWithId:self.forumId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(RKMappingResult *result) {
        successHandler(result);
    } errorHandler:^(NSError *error) {
        [self showErrorWhileLoading:error];
    }];
}

@end
