//
//  CCPrivateMessageProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPrivateMessageProcessingBehaviour.h"
#import "CCNavigationHelper.h"
#import "CCChatTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCAlertHelper.h"
#import "CCDialogsAPIProviderProtocol.h"
#import "CCMessageAPIProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCDialog.h"
#import "CCChatController.h"

#import "MBProgressHUD+Status.h"

typedef void(^LoadMessageSuccessBlock)(id);

@interface CCPrivateMessageProcessingBehaviour ()

@property (nonatomic, strong) id<CCMessageAPIProviderProtocol> ioc_messageApiProvider;
@property (nonatomic, strong) id <CCDialogsAPIProviderProtocol> ioc_dialogsApiProvider;

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
    [self loadDialogWithId:userInfo[@"dialog_id"] successBlock:^(CCDialog *dialog) {
        if(![self isCurrentlyOpenDialog:dialog]){
            [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification
                                 message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                      successButtonTitle:CCAlertsButtons.show
                       cancelButtonTitle:CCAlertsButtons.later
                                 success:^{
                           CCChatTransaction *messageDetailsTransaction = [CCChatTransaction new];
                           messageDetailsTransaction.navigation = [CCNavigationHelper activeNavigationController];
                           [messageDetailsTransaction performWithObject:dialog];
            }];
        }
    }];
}

- (BOOL)isCurrentlyOpenDialog:(CCDialog *)dialog
{
    UINavigationController *activeNavigation = [CCNavigationHelper activeNavigationController];
    UIViewController *currentController = activeNavigation.topViewController;
    if(![currentController isKindOfClass:[CCChatController class]]){
        return NO;
    }
    CCChatController *currentChatController = (CCChatController *)currentController;
    if(currentChatController.dialog.dialogID.intValue == dialog.dialogID.intValue){
        [currentChatController loadNewMessages];
        return YES;
    }
    return NO;
}

- (void)goMessageDetailsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *dialogid = [userInfo objectForKey:@"dialog_id"];
    
    [self loadDialogWithId:dialogid successBlock:^(id dialog) {
        CCChatTransaction *messageDetailsTransaction = [CCChatTransaction new];
        messageDetailsTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [messageDetailsTransaction performWithObject:dialog];
    }];
}


- (void)loadDialogWithId:(NSString *)dialogID successBlock:(LoadMessageSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingMessage];
    [self.ioc_dialogsApiProvider loadDialogWithID:dialogID
                                   SuccessHandler:^(id result) {
                                       [MBProgressHUD hideInKeyWindow];
                                       successBlock(result);
                                   } errorHandler:^(NSError *error) {
                                       [MBProgressHUD hideInKeyWindow];
                                       [CCStandardErrorHandler showErrorWithError:error];
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
