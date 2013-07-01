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
    self.window.backgroundColor = [UIColor blackColor];
    
    [CCAppearanceConfigurator configurate];
    
    CCMainTransaction *transaction = [CCMainTransaction new];
    transaction.window = self.window;
    [transaction perform];
    [self.window makeKeyAndVisible];
    
    // installs HandleExceptions as the Uncaught Exception Handler
    NSSetUncaughtExceptionHandler(&HandleExceptions);
    // create the signal action structure
    struct sigaction newSignalAction;
    // initialize the signal action structure
    memset(&newSignalAction, 0, sizeof(newSignalAction));
    // set SignalHandler as the handler in the signal action structure
    newSignalAction.sa_handler = &SignalHandler;
    // set SignalHandler as the handlers for SIGABRT, SIGILL and SIGBUS
    sigaction(SIGABRT, &newSignalAction, NULL);
    sigaction(SIGILL, &newSignalAction, NULL);
    sigaction(SIGBUS, &newSignalAction, NULL);
    [TestFlight takeOff:@"e2dd5801-3102-4ae1-8a41-a7841748b664"];
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


void HandleExceptions(NSException *exception) {
    NSLog(@"This is where we save the application data during a exception");
}

void SignalHandler(int sig) {
    NSLog(@"This is where we save the application data during a signal");
}



@end
