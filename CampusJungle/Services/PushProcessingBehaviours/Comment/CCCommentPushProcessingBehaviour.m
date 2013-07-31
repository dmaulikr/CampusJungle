//
//  CCCommentPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCommentPushProcessingBehaviour.h"
#import "CCStandardErrorHandler.h"
#import "CCAnswersApiProviderProtocol.h"
#import "CCCommentsTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCAlertHelper.h"
#import "CCNavigationHelper.h"

typedef void(^LoadCommentSuccessBlock)(id);

@interface CCCommentPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCAnswersApiProviderProtocol> ioc_answersApiProvider;
@property (nonatomic, strong) id<CCTransactionWithObject> commentsTransaction;

@end

@implementation CCCommentPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.commentsTransaction = [CCCommentsTransaction new];
        [(CCCommentsTransaction *)self.commentsTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goCommentsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goCommentsWithUserInfo:userInfo];    
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goCommentsWithUserInfo:userInfo];
    }];
}

- (void)goCommentsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *answerId = [userInfo objectForKey:@"answer_id"];
    __weak CCCommentPushProcessingBehaviour *weakSelf = self;
    [self loadAnswerWithId:answerId successBlock:^(id answer) {
        [weakSelf.commentsTransaction performWithObject:answer];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadAnswerWithId:(NSString *)answerId successBlock:(LoadCommentSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingComments];
    [self.ioc_answersApiProvider loadAnswerWithId:answerId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
