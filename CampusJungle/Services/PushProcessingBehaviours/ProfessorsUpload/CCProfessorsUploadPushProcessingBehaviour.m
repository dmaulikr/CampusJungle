//
//  CCProfessorsUploadPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCProfessorsUploadPushProcessingBehaviour.h"
#import "CCTransactionWithObject.h"
#import "CCProfessorUploadsTransaction.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"
#import "CCNavigationHelper.h"
#import "CCAPIProviderProtocol.h"

#import "MBProgressHUD+Status.h"

typedef void(^LoadClassSuccessBlock)(id);

@interface CCProfessorsUploadPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCProfessorsUploadPushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goUploadsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goUploadsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification message:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goUploadsWithUserInfo:userInfo];
    }];
}

- (void)goUploadsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *classId = [userInfo objectForKey:@"class_id"];
    [self loadClassWithId:classId successBlock:^(id classObject) {
        CCProfessorUploadsTransaction *uploadsTransaction = [CCProfessorUploadsTransaction new];
        uploadsTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [uploadsTransaction performWithObject:classObject];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingProfessorsUploads];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
