//
//  CCDropboxDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxDataProvider.h"
#import "CCDropboxFileInfo.h"
#import "CCDropboxAPIProviderProtocol.h"

@interface CCDropboxDataProvider()

@property (nonatomic, strong) id <CCDropboxAPIProviderProtocol> ioc_dropboxProvider;

@end

@implementation CCDropboxDataProvider

- (void)setDropboxPath:(NSString *)dropboxPath
{
    _dropboxPath = dropboxPath;
    [self loadItems];
}

- (void)loadItems
{
    if(self.dropboxPath){
        [self.ioc_dropboxProvider loadMetadataForPath:self.dropboxPath successHandler:^(id response) {
            [self loadItemsFromMetadata:response];
        } errorHanler:^(NSError *error) {
            
        }];
    }
}

- (void)loadItemsFromMetadata:(DBMetadata *)metadata
{
    if (metadata.isDirectory) {
        NSMutableArray *arrayOfFiles = [NSMutableArray new];
        for (DBMetadata *file in metadata.contents) {
            CCDropboxFileInfo *newInfo = [CCDropboxFileInfo new];
            newInfo.fileData = file;
            [arrayOfFiles addObject:newInfo];
        }
        self.arrayOfItems = [self filterArrayOfItems:arrayOfFiles];
        if(self.providerDidFinishLoading){
            self.providerDidFinishLoading();
        }
        [self.targetTable reloadData];
    }
}

- (NSMutableArray *)filterArrayOfItems:(NSMutableArray *)items
{
    return items;
}

@end
