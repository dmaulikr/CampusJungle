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
#import "CCNavigationHelper.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"

typedef void(^LoadClassSuccessBlock)(id);

@interface CCLocationPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> locationTransaction;
@property (nonatomic ,strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCLocationPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.locationTransaction = [CCShowLocationsTransaction new];
        [(CCShowLocationsTransaction *)self.locationTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

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
    __weak CCLocationPushProcessingBehaviour *weakSelf = self;
    NSString *classId = [userInfo objectForKey:@"class_id"];
    [self loadClassWithId:classId successBlock:^(id classObject) {
        [weakSelf.locationTransaction performWithObject:@{@"class" : classObject}];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingLocations];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
