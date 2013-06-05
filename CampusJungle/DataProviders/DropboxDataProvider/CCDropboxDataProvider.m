//
//  CCDropboxDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxDataProvider.h"
#import <DropboxSDK/DropboxSDK.h>

@interface CCDropboxDataProvider()<DBRestClientDelegate>

@property (nonatomic, strong) DBRestClient *restClient;

@end

@implementation CCDropboxDataProvider

- (id)init
{
    if(self = [super init]){
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;
    }
    return self;
}

- (void)loadItems
{
    [[self restClient] loadMetadata:@"/"];
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        NSMutableArray *arrayOfFiles = [NSMutableArray new];
        for (DBMetadata *file in metadata.contents) {
            [arrayOfFiles addObject:file.filename];
        }
        self.arrayOfItems = arrayOfFiles;
        [self.targetTable reloadData];
    }
}

- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
    
    NSLog(@"Error loading metadata: %@", error);
}

@end
