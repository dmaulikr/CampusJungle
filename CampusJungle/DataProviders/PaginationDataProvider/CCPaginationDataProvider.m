//
//  CCPaginationDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPaginationDataProvider.h"
#import "CCPaginationResponse.h"
#import "CCDefines.h"

#define firstPage 1

@implementation CCPaginationDataProvider

- (void)loadItems
{
    self.currentPage = firstPage;
    self.isCurrentlyLoad = YES;
    [self loadItemsForPageNumber:self.currentPage successHandler:^(id responseObject) {
        NSDictionary *response = responseObject;
        self.totalNumber = [response[CCResponseKeys.count] longValue];
        self.arrayOfItems = response[CCResponseKeys.items];
        self.isEverythingLoaded = [self checkIsComplete];
        [self.targetTable reloadData];
        
        self.isCurrentlyLoad = NO;
    }];
    self.currentPage++;
}

- (void)loadMoreItems
{
    if(!self.isCurrentlyLoad && !self.isEverythingLoaded){
        self.isCurrentlyLoad = YES;
        [self loadItemsForPageNumber:self.currentPage successHandler:^(id responseObject) {
            NSDictionary *response = responseObject;
            self.arrayOfItems = [self.arrayOfItems arrayByAddingObjectsFromArray: response[CCResponseKeys.items]];
            self.isEverythingLoaded = [self checkIsComplete];
            [self.targetTable reloadData];
            
            self.isCurrentlyLoad = NO;
        }];
        self.currentPage++;
    }
}

- (BOOL)checkIsComplete
{
    if(self.arrayOfItems.count < self.totalNumber){
        return NO;
    } else {
        return YES;
    }
}

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler {}

@end
