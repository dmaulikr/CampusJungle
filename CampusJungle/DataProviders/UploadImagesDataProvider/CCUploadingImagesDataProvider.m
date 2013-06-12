//
//  CCUploadingImagesDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCUploadingImagesDataProvider.h"

@implementation CCUploadingImagesDataProvider

- (void)loadItems
{
    self.arrayOfItems = self.arrayOfImages;
    self.isEverythingLoaded = YES;
    self.totalNumber = self.arrayOfImages.count;
    [self.targetTable reloadData];
}

@end
