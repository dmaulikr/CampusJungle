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

#import "MBProgressHUD+Status.h"

typedef void(^LoadQuestionSuccessBlock)(id);

@interface CCAnswerPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCQuestionsApiProviderProtocol> ioc_questionsApiProvider;

@end

@implementation CCAnswerPushProcessingBehaviour

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
    [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification message:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goAnswerDetailsWithUserInfo:userInfo];
    }];
}

- (void)goAnswerDetailsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *questionId = [userInfo objectForKey:@"question_id"];
    [self loadQuestionWithId:questionId successBlock:^(id question) {
        CCAnswersTransaction *answersTransaction = [CCAnswersTransaction new];
        answersTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [answersTransaction performWithObject:question];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadQuestionWithId:(NSString *)questionId successBlock:(LoadQuestionSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingAnswers];
    [self.ioc_questionsApiProvider loadQuestionWithId:questionId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
