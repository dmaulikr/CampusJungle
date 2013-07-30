//
//  CCForumPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCForumPushProcessingBehaviour.h"
#import "CCForumDetailsTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCForumsApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"
#import "CCNavigationHelper.h"

typedef void(^LoadForumSuccessBlock)(id);

@interface CCForumPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> forumDetailsTransaction;
@property (nonatomic, strong) id<CCForumsApiProviderProtocol> ioc_forumsApiProvider;

@end

@implementation CCForumPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.forumDetailsTransaction = [CCForumDetailsTransaction new];
        [(CCForumDetailsTransaction *)self.forumDetailsTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goForumDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goForumDetailsWithUserInfo:userInfo];    
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goForumDetailsWithUserInfo:userInfo];
    }];
}

- (void)goForumDetailsWithUserInfo:(NSDictionary *)userInfo
{
    __weak CCForumPushProcessingBehaviour *weakSelf = self;
    NSString *forumId = [userInfo objectForKey:@"forum_id"];
    [self loadForumWithId:forumId successBlock:^(id forum) {
        [weakSelf.forumDetailsTransaction performWithObject:forum];
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
