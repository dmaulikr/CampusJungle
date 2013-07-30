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

typedef void(^LoadClassSuccessBlock)(id);

@interface CCProfessorsUploadPushProcessingBehaviour ()

@property (nonatomic, strong) id<CCTransactionWithObject> uploadsTransaction;
@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@end

@implementation CCProfessorsUploadPushProcessingBehaviour

- (id)init
{
    self = [super init];
    if (self) {
        self.uploadsTransaction = [CCProfessorUploadsTransaction new];
        [(CCProfessorUploadsTransaction *)self.uploadsTransaction setNavigation:[CCNavigationHelper activeNavigationController]];
    }
    return self;
}

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
    [CCAlertHelper showWithMessage:message successButtonTitle:CCAlertsButtons.show cancelButtonTitle:CCAlertsButtons.later success:^{
        [self goUploadsWithUserInfo:userInfo];
    }];

}

- (void)goUploadsWithUserInfo:(NSDictionary *)userInfo
{
    __weak CCProfessorsUploadPushProcessingBehaviour *weakSelf = self;
    NSString *classId = [userInfo objectForKey:@"class_id"];
    [self loadClassWithId:classId successBlock:^(id classObject) {
        [weakSelf.uploadsTransaction performWithObject:classObject];
    }];
}

#pragma mark -
#pragma mark Requests
- (void)loadClassWithId:(NSString *)classId successBlock:(LoadClassSuccessBlock)successBlock
{
    [SVProgressHUD showWithStatus:CCProcessingMessages.loadingClass];
    [self.ioc_apiProvider loadClassWithId:classId successHandler:^(RKMappingResult *result) {
        [SVProgressHUD dismiss];
        successBlock(result);
    } errorHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
