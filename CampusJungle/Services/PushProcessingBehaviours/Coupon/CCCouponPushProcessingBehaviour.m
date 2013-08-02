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

typedef void(^LoadClassSuccessBlock)(id);

@interface CCCouponPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> couponsTransaction;
@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCCouponPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.couponsTransaction = [CCCouponsTransaction new];
        [(CCCouponsTransaction *)self.couponsTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

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
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goCouponsWithUserInfo:userInfo];
    }];
}

- (void)goCouponsWithUserInfo:(NSDictionary *)userInfo
{
    __weak CCCouponPushProcessingBehaviour *weakSelf = self;
    NSString *classId = [userInfo objectForKey:@"class_id"];
    [self loadClassWithId:classId successBlock:^(id classObject) {
        [weakSelf.couponsTransaction performWithObject:classObject];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingCoupons];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
