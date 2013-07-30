//
//  CCPushNotificationsService.m
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//
//

#import "CCPushNotificationsService.h"
#import "CCBadgeHelper.h"
#import "CCUserSessionProtocol.h"
#import "CCDeviceTokenAPIProviderProtocol.h"
#import "CCPush.h"
#import "CCStringHelper.h"

#import "CCPrivateMessageProcessingBehaviour.h"

@interface CCPushNotificationsService () <UIAlertViewDelegate>

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;
@property (nonatomic, strong) id<CCDeviceTokenAPIProviderProtocol> ioc_deviceTokenApiProvider;

@end

@implementation CCPushNotificationsService

+ (void)registerForRemoteNotifications
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

+ (void)processRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"RECEIVED PUSH WITH TYPE = %@ BODY = %@", [userInfo objectForKey:@"type"], userInfo);
    [CCBadgeHelper resetApplicationIconBadge];
    
    NSString *pushType = [userInfo objectForKey:@"type"];
    CCPush *pushNotification = [[CCPush alloc] initWithUserInfo:userInfo];
    
    if ([pushType isEqualToString:CCPushNotificationTypes.privateMessage]) {
        [pushNotification setPushProcessingBehavior:[CCPrivateMessageProcessingBehaviour new]];
    }
    [pushNotification proccessPushNotification];
}

+ (BOOL)isApplicationActive
{
    return ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive);
}

+ (BOOL)isUserLogined
{
    return [[self instance].ioc_userSessionProvider.currentUser.uid length] > 0;
}

+ (void)saveDeviceToken:(NSData *)deviceToken
{
    NSString *tokenString = [NSString stringWithString:[[deviceToken description] uppercaseString]];
    tokenString = [CCStringHelper removeServiceSymbolsFromDeviceTokenString:tokenString];
    NSLog(@"device token: %@", tokenString);
    [[self instance].ioc_userSessionProvider setDeviceToken:tokenString];
    [self linkDeviceToken:tokenString];
}

+ (void)resetAllPushesCounters
{
    [CCBadgeHelper resetApplicationIconBadge];
}

+ (CCPushNotificationsService *)instance
{
    return [CCPushNotificationsService new];
}

#pragma mark -
#pragma mark Requests
+ (void)linkDeviceToken:(NSString *)deviceToken
{
    [[self instance].ioc_deviceTokenApiProvider linkDeviceToken:deviceToken successHandler:^(RKMappingResult *result) {
        NSLog(@"linked device token");
    } errorHandler:^(NSError *error) {
        NSLog(@"error during linking device token = %@", error);
    }];
}

+ (void)unlinkDeviceTokenWithSuccessBlock:(LogoutSuccessBlock)successBlock errorBlock:(LogoutErrorBlock)errorBlock
{
    NSString *deviceToken = [self instance].ioc_userSessionProvider.deviceToken;
    if (deviceToken) {
        [[self instance].ioc_deviceTokenApiProvider unlinkDeviceToken:deviceToken successHandler:^(RKMappingResult *result) {
            NSLog(@"unlinked device token");
            if (successBlock) {
                successBlock();
            }
        } errorHandler:^(NSError *error) {
            if (errorBlock) {
                errorBlock(error);
            }
            NSLog(@"error during unlinking device token = %@", error);
        }];
    }
    else {
        if (successBlock) {
            successBlock();
        }
    }
}

+ (void)resetPushesCounterWithType:(NSString *)type
{
    // TODO
}

@end
