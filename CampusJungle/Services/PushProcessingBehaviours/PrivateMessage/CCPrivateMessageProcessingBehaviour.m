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

#import "MBProgressHUD+Status.h"

typedef void(^LoadMessageSuccessBlock)(id);

@interface CCPrivateMessageProcessingBehaviour ()

@property (nonatomic, strong) id<CCMessageAPIProviderProtocol> ioc_messageApiProvider;

@end

@implementation CCPrivateMessageProcessingBehaviour

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
    [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification message:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goMessageDetailsWithUserInfo:userInfo];
    }];
}

- (void)goMessageDetailsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *messageid = [userInfo objectForKey:@"message_id"];
    [self loadMessageWithId:messageid successBlock:^(id message) {
        CCMessageDetailsTransaction *messageDetailsTransaction = [CCMessageDetailsTransaction new];
        messageDetailsTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [messageDetailsTransaction performWithObject:message];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadMessageWithId:(NSString *)messageId successBlock:(LoadMessageSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingMessage];
    [self.ioc_messageApiProvider loadMessageWithId:messageId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}


@end
