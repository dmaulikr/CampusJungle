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

#import "MBProgressHUD+Status.h"

typedef void(^LoadCommentSuccessBlock)(id);

@interface CCCommentPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCAnswersApiProviderProtocol> ioc_answersApiProvider;

@end

@implementation CCCommentPushProcessingBehaviour

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
    [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification message:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goCommentsWithUserInfo:userInfo];
    }];
}

- (void)goCommentsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *answerId = [userInfo objectForKey:@"answer_id"];
    [self loadAnswerWithId:answerId successBlock:^(id answer) {
        CCCommentsTransaction *commentsTransaction = [CCCommentsTransaction new];
        commentsTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [commentsTransaction performWithObject:answer];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadAnswerWithId:(NSString *)answerId successBlock:(LoadCommentSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingComments];
    [self.ioc_answersApiProvider loadAnswerWithId:answerId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
