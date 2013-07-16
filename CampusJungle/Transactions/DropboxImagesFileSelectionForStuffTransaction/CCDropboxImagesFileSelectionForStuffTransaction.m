//
//  CCDropboxImagesFileSelectionForStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCDropboxImagesFileSelectionForStuffTransaction.h"
#import "CCImageSortingControllerForStuff.h"

@implementation CCDropboxImagesFileSelectionForStuffTransaction

- (Class)sortingControllerClass
{
    return [CCImageSortingControllerForStuff class];
}

@end
