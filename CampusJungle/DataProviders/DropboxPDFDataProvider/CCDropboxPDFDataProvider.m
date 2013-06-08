//
//  CCDropboxPDFDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 06.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxPDFDataProvider.h"
#import "CCDropboxFileInfo.h"

@implementation CCDropboxPDFDataProvider

- (NSMutableArray *)filterArrayOfItems:(NSMutableArray *)items
{
    NSMutableArray *arrayOfFiltredItems = [NSMutableArray new];
    for(CCDropboxFileInfo *info in items){
        if(info.fileData.isDirectory || [info.fileData.icon isEqualToString:@"page_white_acrobat"] || [info.fileData.icon isEqualToString:@"page_white_acrobat_import"]){
            [arrayOfFiltredItems addObject:info];
        }
    }
    return arrayOfFiltredItems;
}

@end
