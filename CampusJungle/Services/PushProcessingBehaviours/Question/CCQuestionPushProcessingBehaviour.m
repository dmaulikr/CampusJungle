//
//  CCQuestionPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCQuestionPushProcessingBehaviour.h"
#import "CCTransactionWithObject.h"
#import "CCForumDetailsTransaction.h"
#import "CCNavigationHelper.h"
#import "CCAlertHelper.h"
#import "CCForum.h"

#import "CCForumsApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"

#import "MBProgressHUD+Status.h"

typedef void(^LoadForumSuccessBlock)(id);

@interface CCQuestionPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCForumsApiProviderProtocol> ioc_forumsApiProvider;

@end

@implementation CCQuestionPushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goQuestionsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goQuestionsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goQuestionsWithUserInfo:userInfo];
    }];
}

- (void)goQuestionsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *forumId = [userInfo objectForKey:@"forum_id"];
    [self loadForumWithId:forumId successBlock:^(id forum) {
        CCForumDetailsTransaction *questionsTransaction = [CCForumDetailsTransaction new];
        questionsTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [questionsTransaction performWithObject:forum];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadForumWithId:(NSString *)forumId successBlock:(LoadForumSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingQuestion];
    [self.ioc_forumsApiProvider loadForumWithId:forumId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
