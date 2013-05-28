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

@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SHOmniAuth registerProvidersWith:^(SHOmniAuthProviderBlock provider) {
        provider(SHOmniAuthTwitter.provider, @"5PArGIFtG4ZxIm5tm02g",
                 @"CdvGtu0kuTvezy4jnJOx6HVRU3PaMkC9ZlmiPLc",
                 nil, @"CampusJungle://success");
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
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
}


@end
