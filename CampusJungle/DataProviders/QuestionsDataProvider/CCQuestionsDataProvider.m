//
//  CCQuestionsDataProvider.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestionsDataProvider.h"
#import "CCQuestionsApiProviderProtocol.h"
#import "CCUploadProcessManagerProtocol.h"

@interface CCQuestionsDataProvider ()

@property (nonatomic, strong) id<CCQuestionsApiProviderProtocol> ioc_questionsApiProvider;
@property (nonatomic, strong) id<CCUploadProcessManagerProtocol> ioc_uploadManager;

@end

@implementation CCQuestionsDataProvider

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler
{
    if (self.classId) {
        [self.ioc_questionsApiProvider loadQuestionsForClassWithId:self.classId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(NSMutableDictionary *result) {
            if([[self.ioc_uploadManager uploadingQuestions] count]){
                [self.ioc_uploadManager setCurrentDataProvider:self];
                NSMutableArray *allQuestions = [NSMutableArray arrayWithArray:[self arrayOfFiltredUploads]];
                [allQuestions addObjectsFromArray:result[@"items"]];
                result[@"items"] = allQuestions;
                successHandler(result);
            } else {
                successHandler(result);
            }

        } errorHandler:^(NSError *error) {
            [self showErrorWhileLoading:error];
        }];
    }
    else {
        [self.ioc_questionsApiProvider loadQuestionsForGroupWithId:self.groupId filterString:self.searchQuery pageNumber:numberOfPage successHandler:^(NSMutableDictionary *result) {
            if([[self.ioc_uploadManager uploadingQuestions] count]){
                [self.ioc_uploadManager setCurrentDataProvider:self];
                NSMutableArray *allQuestions = [NSMutableArray arrayWithArray:[self arrayOfFiltredUploads]];
                [allQuestions addObjectsFromArray:result[@"items"]];
                result[@"items"] = allQuestions;
                successHandler(result);
            } else {
                successHandler(result);
            }
            
        } errorHandler:^(NSError *error) {
            [self showErrorWhileLoading:error];
        }];
    }
}

- (NSArray *)arrayOfFiltredUploads
{
    NSMutableArray *arrayOfFiltredItems = [NSMutableArray new];
    NSArray *sourceArray = [self.ioc_uploadManager uploadingQuestions];
    for (CCQuestion *question in sourceArray) {
        if (self.classId && [question.classId isEqualToString:self.classId]) {
            [arrayOfFiltredItems addObject:question];
        }
        else if (self.groupId && [question.groupId isEqualToString:self.groupId]) {
            [arrayOfFiltredItems addObject:question];
        }
    }
    return arrayOfFiltredItems;
}

@end
