//
//  CCDropboxDelegate.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxAPIProvider.h"
#import <DropboxSDK/DropboxSDK.h>
#import "CCDefines.h"

@implementation CCDropboxAPIProvider

static int outstandingRequests;

- (void)networkRequestStarted {
	outstandingRequests++;
	if (outstandingRequests == 1) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)networkRequestStopped {
	outstandingRequests--;
	if (outstandingRequests == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId {
	[[[UIAlertView alloc]
	   initWithTitle:@"Dropbox Session Ended" message:@"Do you want to relink?" delegate:self
	   cancelButtonTitle:@"Cancel" otherButtonTitles:@"Relink", nil]
	 show];
}

- (void)createSession
{
    NSString* appKey = CCDropboxDefines.appKey;
	NSString* appSecret = CCDropboxDefines.appSecret;
	NSString *root = kDBRootDropbox;
    
    DBSession* session = [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
	session.delegate = self;
	[DBSession setSharedSession:session];
    [DBRequest setNetworkRequestDelegate:self];
}

- (void)linkWithController:(UIViewController *)controller
{
    [[DBSession sharedSession] linkFromController:controller];
}

- (void)unlink
{
    [[DBSession sharedSession] unlinkAll];
}

- (BOOL)isLinked
{
    return [[DBSession sharedSession] isLinked];
}

@end
