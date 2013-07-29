//
//  CCPush.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//  Copyright (c) 2013 111Minutes. All rights reserved.
//

#import "CCPush.h"
#import "CCUserSessionProtocol.h"

@interface CCPush ()

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) id<CCPushProcessingProtocol> pushProcessingBehavior;
@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;

@end

@implementation CCPush

- (id)initWithUserInfo:(NSDictionary *)userInfo
{
    self = [super init];
    if (self) {
        self.userInfo = userInfo;
    }
    return self;
}

- (void)proccessPushNotification
{
    if (![self isApplicationActive]) {
        if ([self isUserLogined]) {
            [self.pushProcessingBehavior processWhenAppInBackgroundWithUserInfo:_userInfo];
        }
        else {
            [self.pushProcessingBehavior processWhenAppNotRunningWithUserInfo:_userInfo];
        }
    }
    else {
        [self.pushProcessingBehavior processWhenAppActiveWithUserInfo:_userInfo];
    }
}

- (BOOL)isApplicationActive
{
    return ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive);
}

- (BOOL)isUserLogined
{
    return [self.ioc_userSessionProvider.currentUser.uid length] > 0;
}

@end
