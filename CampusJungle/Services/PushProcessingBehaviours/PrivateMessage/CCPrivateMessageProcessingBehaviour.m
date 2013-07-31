//
//  CCPrivateMessageProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPrivateMessageProcessingBehaviour.h"
#import "CCNavigationHelper.h"
#import "CCMessageDetailsTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCAlertHelper.h"

#import "CCMessageAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"

typedef void(^LoadMessageSuccessBlock)(id);

@interface CCPrivateMessageProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> messageDetailsTransaction;
@property (nonatomic, strong) id<CCMessageAPIProviderProtocol> ioc_messageApiProvider;

@end

@implementation CCPrivateMessageProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.messageDetailsTransaction = [CCMessageDetailsTransaction new];
        [(CCMessageDetailsTransaction *)self.messageDetailsTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goMessageDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goMessageDetailsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goMessageDetailsWithUserInfo:userInfo];
    }];
}

- (void)goMessageDetailsWithUserInfo:(NSDictionary *)userInfo
{
    __weak CCPrivateMessageProcessingBehaviour *weakSelf = self;
    NSString *messageid = [userInfo objectForKey:@"message_id"];
    [self loadMessageWithId:messageid successBlock:^(id message) {
        [weakSelf.messageDetailsTransaction performWithObject:message];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadMessageWithId:(NSString *)messageId successBlock:(LoadMessageSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingMessage];
    [self.ioc_messageApiProvider loadMessageWithId:messageId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}


@end
