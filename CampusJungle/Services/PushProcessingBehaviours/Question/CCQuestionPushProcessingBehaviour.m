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

typedef void(^LoadForumSuccessBlock)(id);

@interface CCQuestionPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> questionsTransaction;
@property (nonatomic, strong) id<CCForumsApiProviderProtocol> ioc_forumsApiProvider;

@end

@implementation CCQuestionPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.questionsTransaction = [CCForumDetailsTransaction new];
        [(CCForumDetailsTransaction *)self.questionsTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

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
    __weak CCQuestionPushProcessingBehaviour *weakSelf = self;
    NSString *forumId = [userInfo objectForKey:@"forum_id"];
    [self loadForumWithId:forumId successBlock:^(id forum) {
        [weakSelf.questionsTransaction performWithObject:forum];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadForumWithId:(NSString *)forumId successBlock:(LoadForumSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingForum];
    [self.ioc_forumsApiProvider loadForumWithId:forumId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
