//
//  CCPushNotificationsService.h
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//
//

@interface CCPushNotificationsService : NSObject

+ (void)registerForRemoteNotifications;
+ (void)processRemoteNotification:(NSDictionary *)userInfo;
+ (void)sendDeviceToken:(NSString *)deviceToken;
+ (void)resetAllPushesCounters;
+ (void)saveDeviceToken:(NSData *)deviceToken;

@end
