//
//  CCUploadManager.m
//  CampusJungle
//
//  Created by Vlad Korzun on 04.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUploadProcessManager.h"

@implementation CCUploadProcessManager

- (id)init
{
    if(self = [super init]){
        self.uploadingNotes = [NSMutableArray new];
        self.uploadingStuff = [NSMutableArray new];
    }
    return self;
}

- (void)reloadDelegate
{
    [self.currentDataProvider loadItems];
}

@end
