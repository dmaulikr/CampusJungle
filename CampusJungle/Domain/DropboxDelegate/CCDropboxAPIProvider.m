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
#import "CCDropboxFileInfo.h"

@interface CCDropboxAPIProvider()<DBRestClientDelegate>

@property (nonatomic, strong) NSMutableDictionary *metadataRequests;
@property (nonatomic, strong) NSMutableDictionary *thumbnailRequests;
@property (nonatomic, strong) NSMutableDictionary *directURLRequest;
@property (nonatomic, strong) DBRestClient *restClient;

#define successConsatnt @"success"
#define errorConsatnt @"error"

@end

@implementation CCDropboxAPIProvider

static int outstandingRequests;

- (id)init
{
    if (self = [super init]){
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;
        self.metadataRequests = [NSMutableDictionary new];
        self.thumbnailRequests = [NSMutableDictionary new];
        self.directURLRequest = [NSMutableDictionary new];
    }
    return self;
}

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
    self.restClient = [[DBRestClient alloc] initWithSession:session];
    self.restClient.delegate = self;
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

- (void)loadMetadataForPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler
{
    [self.metadataRequests setValue:[successHandler copy] forKey:[path stringByAppendingString:successConsatnt]];
    [self.metadataRequests setValue:[errorHanler copy] forKey:[path stringByAppendingString:errorConsatnt]];
    [self.restClient loadMetadata:path];
}

- (void)loadThumbnailForPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler
{
    [self.thumbnailRequests setValue:[successHandler copy] forKey:[path stringByAppendingString:successConsatnt]];
    [self.thumbnailRequests setValue:[errorHanler copy] forKey:[path stringByAppendingString:errorConsatnt]];
    NSString *localFileName = [path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    [self.restClient loadThumbnail:path ofSize:@"s" intoPath:[NSTemporaryDirectory() stringByAppendingPathComponent:localFileName]];
}

- (void)loadDirectURLforPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler
{
    [self.directURLRequest setValue:[successHandler copy] forKey:[path stringByAppendingString:successConsatnt]];
    [self.directURLRequest setValue:[errorHanler copy] forKey:[path stringByAppendingString:errorConsatnt]];
    [self.restClient loadStreamableURLForFile:path];
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    successWithObject block = self.metadataRequests[[metadata.path stringByAppendingString:successConsatnt]];
    
    if(block){
        block(metadata);
    }
}

- (void)restClient:(DBRestClient *)client loadedThumbnail:(NSString *)destPath metadata:(DBMetadata *)metadata {
    successWithObject block = self.thumbnailRequests[[metadata.path stringByAppendingString:successConsatnt]];
    if(block){
        block(@{
              @"image" : [UIImage imageWithContentsOfFile:destPath],
              @"path" : metadata.path
              });
    }
}

- (void)restClient:(DBRestClient *)client loadedStreamableURL:(NSURL *)url forFile:(NSString *)path
{
    successWithObject block = self.directURLRequest[[path stringByAppendingString:successConsatnt]];
    if(block){
        block(url);
    }
}

@end
