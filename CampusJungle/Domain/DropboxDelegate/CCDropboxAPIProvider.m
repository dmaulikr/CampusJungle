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
        if([DBSession sharedSession]){
            self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
            self.restClient.delegate = self;
        }
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

- (void)createRestCliet
{
    [self createSession];
    if(!self.restClient){
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;
    }
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
    [self.restClient cancelAllRequests];
    self.restClient = nil;
    [[DBSession sharedSession] unlinkAll];
}

- (BOOL)isLinked
{
    return [[DBSession sharedSession] isLinked];
}

- (void)loadMetadataForPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler
{
    [self.metadataRequests setValue:[successHandler copy] forKey:[self successKeyForPath:path]];
    [self.metadataRequests setValue:[errorHanler copy] forKey:[self errorKeyForPath:path]];
    [self.restClient loadMetadata:path];
}

- (void)loadThumbnailForPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler
{

    [self.thumbnailRequests setValue:[successHandler copy] forKey:[self successKeyForPath:path]];
    [self.thumbnailRequests setValue:[errorHanler copy] forKey:[self errorKeyForPath:path]];
    NSString *localFileName = [path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    localFileName = [NSTemporaryDirectory() stringByAppendingPathComponent:localFileName];
    UIImage* cachedImage = [self loadImageFromCachePath:localFileName];
    if (!cachedImage){
        [self.restClient loadThumbnail:path ofSize:@"s" intoPath:localFileName];
    } else {
        successHandler(@{
              @"image" : cachedImage,
              @"path" : path
              });
    }
    
}

- (UIImage *)loadImageFromCachePath:(NSString *)path
{
    return [UIImage imageWithContentsOfFile:path];
}

- (void)loadDirectURLforPath:(NSString *)path successHandler:(successWithObject)successHandler errorHanler:(errorHandler)errorHanler
{
    [self.directURLRequest setValue:[successHandler copy] forKey:[self successKeyForPath:path]];
    [self.directURLRequest setValue:[errorHanler copy] forKey:[self errorKeyForPath:path]];
    [self.restClient loadStreamableURLForFile:path];
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    successWithObject block = self.metadataRequests[[self successKeyForPath:metadata.path]];
    
    if(block){
        block(metadata);
    }
    [self cleanDictionary:self.metadataRequests forPath:metadata.path];
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
{

}

- (void)restClient:(DBRestClient *)client loadedThumbnail:(NSString *)destPath metadata:(DBMetadata *)metadata {
    successWithObject block = self.thumbnailRequests[[self successKeyForPath:metadata.path]];
    if(block){
        block(@{
              @"image" : [self loadImageFromCachePath:destPath],
              @"path" : metadata.path
              });
    }
    [self cleanDictionary:self.thumbnailRequests forPath:metadata.path];
}

- (void)restClient:(DBRestClient *)client loadThumbnailFailedWithError:(NSError *)error
{

}

- (void)restClient:(DBRestClient *)client loadedStreamableURL:(NSURL *)url forFile:(NSString *)path
{
    successWithObject block = self.directURLRequest[[self successKeyForPath:path]];
    if(block){
        block(url);
    }
    [self cleanDictionary:self.directURLRequest forPath:path];
}

- (void)restClient:(DBRestClient *)client loadStreamableURLFailedWithError:(NSError *)error
{
    NSString *path = error.userInfo[@"path"];
    errorHandler block =  self.directURLRequest[[self successKeyForPath:path]];
    if(block){
        block(error);
    }
    [self cleanDictionary:self.directURLRequest forPath:path];
}

- (void)cleanDictionary:(NSMutableDictionary *)dictionary forPath:(NSString *)path
{
    [dictionary removeObjectForKey:[self successKeyForPath:path]];
    [dictionary removeObjectForKey:[self errorKeyForPath:path]];
}

- (NSString *)successKeyForPath:(NSString *)path
{
    return [path stringByAppendingString:successConsatnt];
}

- (NSString *)errorKeyForPath:(NSString *)path
{
    return [path stringByAppendingString:errorConsatnt];
}

- (void)checkAllDirectURLForArray:(NSArray *)arrayOfMetadata successHandler:(successWithObject)successHandler
{
    [self.restClient cancelAllRequests];
    NSMutableArray *arrayReadyForUpload = [NSMutableArray new];
    NSMutableArray *arrayNotReadyForUpload = [NSMutableArray new];
    for(CCDropboxFileInfo *info in arrayOfMetadata){
        if(info.directLink){
            [arrayReadyForUpload addObject:info];
        } else {
            [arrayNotReadyForUpload addObject:info];
        }
    }
    if(!arrayNotReadyForUpload.count){
        successHandler(arrayReadyForUpload);
    } else {
        for(CCDropboxFileInfo *info in arrayNotReadyForUpload){
            [self loadDirectURLforPath:info.fileData.path successHandler:^(id result) {
                info.directLink = result;
                if(self.restClient.requestCount == 1){
                    [self checkAllDirectURLForArray:arrayOfMetadata successHandler:successHandler];
                }
            } errorHanler:^(NSError *error) {
                if(self.restClient.requestCount == 1){
                    [self checkAllDirectURLForArray:arrayOfMetadata successHandler:successHandler];
                }
            }];
        }
    }
    
}

@end
