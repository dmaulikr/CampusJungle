//
//  CCAppDelegate.m
//  CollegeConnect
//
//  Created by Yulia Petryshena on 5/8/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAppDelegate.h"
#import "CCRestKitConfigurator.h"
#import "CCMainTransaction.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SHOmniAuth.h"
#import "SHOmniAuthTWitter.h"
#import "AFOAuth1Client.h"
#import "CCDefines.h"
#import <DropboxSDK/DropboxSDK.h>
#import <TestFlightSDK/TestFlight.h>
#import "CCAppearanceConfigurator.h"
#import "CCPushNotificationsService.h"
#import "CCBadgeHelper.h"

@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SHOmniAuth registerProvidersWith:^(SHOmniAuthProviderBlock provider) {
        provider(SHOmniAuthTwitter.provider, CCTwitterDefines.appKey,CCTwitterDefines.appSecret,
                 nil, CCTwitterDefines.appURLSchema);
    }];

    [AppleGuice startServiceWithImplementationDiscoveryPolicy:AppleGuiceImplementationDiscoveryPolicyRuntime];
    [CCRestKitConfigurator configure];
    [CCAppearanceConfigurator configurate];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    CCMainTransaction *transaction = [CCMainTransaction new];
    transaction.window = self.window;
    [transaction perform];
    [self.window makeKeyAndVisible];
    
    [TestFlight takeOff:@"e2dd5801-3102-4ae1-8a41-a7841748b664"];
    
    [self processLaunchOptions:launchOptions];
    return YES;
}

- (void)processLaunchOptions:(NSDictionary *)launchOptions
{
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [CCPushNotificationsService processRemoteNotification:userInfo];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[DBSession sharedSession] handleOpenURL:url]) {
       [[NSNotificationCenter defaultCenter] postNotificationName:CCAppDelegateDefines.dropboxLinked object:nil];
        return YES;
    }
    
    NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:[NSDictionary dictionaryWithObject:url forKey:kAFApplicationLaunchOptionsURLKey]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [FBSession.activeSession handleOpenURL:url];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [CCBadgeHelper resetApplicationIconBadge];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CCAppDelegateDefines.notificationOnBackToForeground object:nil ];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [CCPushNotificationsService saveDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"failed to register for remote notifications");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [CCPushNotificationsService processRemoteNotification:userInfo];
}

@end
