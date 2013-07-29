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
#import "CCPush.h"
#import "CCStringHelper.h"

@interface CCPushNotificationsService () <UIAlertViewDelegate>

@property (nonatomic, strong) id<CCUserSessionProtocol> ioc_userSessionProvider;

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
    
// TODO set proper push processing behavour
// EXAMPLE
//    if ([pushType isEqualToString:KCPushesTypesStruct.invite]) {
//        [pushNotification setPushProcessingBehavior:[KCInvitePushProcessingBehavior new]];
//    }
    [pushNotification proccessPushNotification];
}

+ (BOOL)isApplicationActive
{
    return ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive);
}

+ (BOOL)isUserLogined
{
    return [[CCPushNotificationsService new].ioc_userSessionProvider.currentUser.uid length] > 0;
}

+ (void)saveDeviceToken:(NSData *)deviceToken
{
    NSString *tokenString = [NSString stringWithString:[[deviceToken description] uppercaseString]];
    tokenString = [CCStringHelper removeServiceSymbolsFromDeviceTokenString:tokenString];
    NSLog(@"device token: %@", tokenString);
    [self sendDeviceToken:tokenString];
}

+ (void)resetAllPushesCounters
{
    [CCBadgeHelper resetApplicationIconBadge];
}

#pragma mark -
#pragma mark Requests
+ (void)sendDeviceToken:(NSString *)deviceToken
{
    // TODO
}

+ (void)resetPushesCounterWithType:(NSString *)type
{
    // TODO
}

@end
