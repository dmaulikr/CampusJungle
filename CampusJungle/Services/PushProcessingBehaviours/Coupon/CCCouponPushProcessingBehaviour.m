//
//  CCCouponPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCouponPushProcessingBehaviour.h"
#import "CCAPIProvider.h"
#import "CCCouponsTransaction.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"
#import "CCNavigationHelper.h"

#import "MBProgressHUD+Status.h"

typedef void(^LoadClassSuccessBlock)(id);

@interface CCCouponPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCCouponPushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goCouponsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goCouponsWithUserInfo:userInfo];    
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithTitle:CCAlertsTitles.pushNotification message:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goCouponsWithUserInfo:userInfo];
    }];
}

- (void)goCouponsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *classId = [userInfo objectForKey:@"class_id"];
    [self loadClassWithId:classId successBlock:^(id classObject) {
        CCCouponsTransaction *couponsTransaction = [CCCouponsTransaction new];
        couponsTransaction.navigation = [CCNavigationHelper activeNavigationController];
        [couponsTransaction performWithObject:classObject];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingCoupons];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
