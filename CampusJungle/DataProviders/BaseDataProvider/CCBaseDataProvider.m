//
//  CCBaseDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseDataProvider.h"
#import "CCStandardErrorHandler.h"

@implementation CCBaseDataProvider

- (void)showErrorWhileLoading:(NSError *)error
{
    [CCStandardErrorHandler showErrorWithError:error];
}

- (BOOL)isEmpty
{
    return !self.arrayOfItems.count;
}

- (void)loadMoreItems{}

@end
