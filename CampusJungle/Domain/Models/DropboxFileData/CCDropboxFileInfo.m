//
//  CCDropboxFileInfo.m
//  CampusJungle
//
//  Created by Vlad Korzun on 05.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxFileInfo.h"

@implementation CCDropboxFileInfo

+ (NSArray *)arrayOfDirectLinksFromArrayOfInfo:(NSArray *)arrayOfInfo
{
    NSMutableArray *arrayOfUrls = [NSMutableArray new];
    for(CCDropboxFileInfo *info in arrayOfInfo){
        [arrayOfUrls addObject:info.directLink];
    }
    return arrayOfUrls;
}

@end
