//
//  CCAnswerPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAnswerPushProcessingBehaviour.h"
#import "CCTransactionWithObject.h"
#import "CCAnswersTransaction.h"
#import "CCNavigationHelper.h"
#import "CCAlertHelper.h"

#import "CCQuestionsApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"

typedef void(^LoadQuestionSuccessBlock)(id);

@interface CCAnswerPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCQuestionsApiProviderProtocol> ioc_questionsApiProvider;
@property (nonatomic, strong) id<CCTransactionWithObject> answersTransaction;

@end

@implementation CCAnswerPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.answersTransaction = [CCAnswersTransaction new];
        [(CCAnswersTransaction *)self.answersTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goAnswerDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goAnswerDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goAnswerDetailsWithUserInfo:userInfo];
    }];
}

- (void)goAnswerDetailsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *questionId = [userInfo objectForKey:@"question_id"];
    __weak CCAnswerPushProcessingBehaviour *weakSelf = self;
    [self loadQuestionWithId:questionId successBlock:^(id question) {
        [weakSelf.answersTransaction performWithObject:question];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadQuestionWithId:(NSString *)questionId successBlock:(LoadQuestionSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingAnswers];
    [self.ioc_questionsApiProvider loadQuestionWithId:questionId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
