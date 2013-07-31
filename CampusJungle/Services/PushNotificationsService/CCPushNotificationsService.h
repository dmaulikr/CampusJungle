//
//  CCPushNotificationsService.h
//  CampusJungle
//
//  Created by Yury Grinenko on 29.07.13.
//
//

typedef void(^LogoutSuccessBlock)();
typedef void(^LogoutErrorBlock)(NSError *);

@interface CCPushNotificationsService : NSObject

+ (void)registerForRemoteNotifications;
+ (void)processRemoteNotification:(NSDictionary *)userInfo;
+ (void)linkDeviceToken:(NSString *)deviceToken;
+ (void)unlinkDeviceTokenWithSuccessBlock:(LogoutSuccessBlock)successBlock errorBlock:(LogoutErrorBlock)errorBlock;
+ (void)resetAllPushesCounters;
+ (void)saveDeviceToken:(NSData *)deviceToken;

@end
