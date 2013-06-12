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


@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SHOmniAuth registerProvidersWith:^(SHOmniAuthProviderBlock provider) {
        provider(SHOmniAuthTwitter.provider, CCTwitterDefines.appKey,CCTwitterDefines.appSecret,
                 nil, CCTwitterDefines.appURLSchema);
    }];

    [AppleGuice startServiceWithImplementationDiscoveryPolicy:AppleGuiceImplementationDiscoveryPolicyRuntime];
    
    [CCRestKitConfigurator configure];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    CCMainTransaction *transaction = [CCMainTransaction new];
    transaction.window = self.window;
    [transaction perform];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
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

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CCAppDelegateDefines.notificationOnBackToForeground object:nil ];
}

@end
