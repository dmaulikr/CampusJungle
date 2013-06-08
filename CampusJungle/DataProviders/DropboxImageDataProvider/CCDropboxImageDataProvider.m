//
//  CCDropboxImageDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxImageDataProvider.h"
#import "CCDropboxFileInfo.h"

@implementation CCDropboxImageDataProvider

- (NSMutableArray *)filterArrayOfItems:(NSMutableArray *)items
{
    NSMutableArray *arrayOfFiltredItems = [NSMutableArray new];
    for(CCDropboxFileInfo *info in items){
        if(info.fileData.isDirectory || info.fileData.thumbnailExists){
            [arrayOfFiltredItems addObject:info];
        }
    }
    return arrayOfFiltredItems;
}

@end
