//
//  CCDropboxDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxDataProvider.h"
#import <DropboxSDK/DropboxSDK.h>
#import "CCDropboxFileInfo.h"

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

- (void)setDropboxPath:(NSString *)dropboxPath
{
    _dropboxPath = dropboxPath;
    [self loadItems];
}

- (void)loadItems
{
    if(self.dropboxPath){
        [[self restClient] loadMetadata:self.dropboxPath];
    }
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        NSMutableArray *arrayOfFiles = [NSMutableArray new];
        for (DBMetadata *file in metadata.contents) {
            CCDropboxFileInfo *newInfo = [CCDropboxFileInfo new];
            newInfo.fileData = file;
            [arrayOfFiles addObject:newInfo];
        }
        self.arrayOfItems = arrayOfFiles;
        [self.targetTable reloadData];
    }
}

@end
