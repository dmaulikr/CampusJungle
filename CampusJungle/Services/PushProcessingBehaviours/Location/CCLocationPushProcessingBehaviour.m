//
//  CCLocationPushProcessingBehaviour.m
//  CampusJungle
//
//  Created by Yury Grinenko on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCLocationPushProcessingBehaviour.h"
#import "CCShowLocationsTransaction.h"
#import "CCTransactionWithObject.h"
#import "CCAPIProvider.h"
#import "CCGroupsApiProviderProtocol.h"
#import "CCNavigationHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"

#import "MBProgressHUD+Status.h"

typedef void(^LoadClassSuccessBlock)(id);

@interface CCLocationPushProcessingBehaviour ()

@property (nonatomic ,strong) id<CCAPIProviderProtocol> ioc_apiProvider;
@property (nonatomic, strong) id<CCGroupsApiProviderProtocol> ioc_groupsApiProvider;

@end

@implementation CCLocationPushProcessingBehaviour

- (void)processWhenAppNotRunningWithUserInfo:(NSDictionary *)userInfo
{
    [self goLocationsWithUserInfo:userInfo];
}

- (void)processWhenAppInBackgroundWithUserInfo:(NSDictionary *)userInfo
{
    [self goLocationsWithUserInfo:userInfo];
}

- (void)processWhenAppActiveWithUserInfo:(NSDictionary *)userInfo
{
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goLocationsWithUserInfo:userInfo];
    }];
}

- (void)goLocationsWithUserInfo:(NSDictionary *)userInfo
{
    NSString *placeType = [userInfo objectForKey:@"place_type"];
    NSString *placeId = [userInfo objectForKey:@"place_id"];
    if ([placeType isEqualToString:@"Group"]) {
        [self loadGroupWithId:placeId successBlock:^(id group) {
            CCShowLocationsTransaction *locationTransaction = [CCShowLocationsTransaction new];
            locationTransaction.navigation = [CCNavigationHelper activeNavigationController];
            [locationTransaction performWithObject:@{@"group" : group}];
        }];
    }
    else {
        [self loadClassWithId:placeId successBlock:^(id classObject) {
            CCShowLocationsTransaction *locationTransaction = [CCShowLocationsTransaction new];
            locationTransaction.navigation = [CCNavigationHelper activeNavigationController];
            [locationTransaction performWithObject:@{@"class" : classObject}];
        }];
    }
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingLocations];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

- (void)loadGroupWithId:(NSString *)groupId successBlock:(LoadClassSuccessBlock)successBlock
{
    [MBProgressHUD showInKeyWindowWithStatus:CCProcessingMessages.loadingLocations];
    [self.ioc_groupsApiProvider loadGroupWithId:groupId successHandler:^(RKMappingResult *result) {
        [MBProgressHUD hideInKeyWindow];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [MBProgressHUD hideInKeyWindow];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
