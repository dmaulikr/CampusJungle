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

@implementation CCPaginationDataProvider

- (void)loadItems
{
    if(self.beforeLoadingFilter){
        self.beforeLoadingFilter();
    }
    self.currentPage = firstPage;
    self.isCurrentlyLoad = YES;
    __weak CCPaginationDataProvider *weakSelf = self;
    [self loadItemsForPageNumber:self.currentPage successHandler:^(id responseObject) {
        NSDictionary *response = responseObject;
        weakSelf.totalNumber = [response[CCResponseKeys.count] longValue];
        weakSelf.arrayOfItems = response[CCResponseKeys.items];
        weakSelf.isEverythingLoaded = [self checkIsComplete];

        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.tableViewWillReloadData object:nil];
        [weakSelf.targetTable reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.tableViewDidReloadData object:nil];
        
        weakSelf.isCurrentlyLoad = NO;
        if(self.afterLoadingFilter){
            self.afterLoadingFilter();
        }
    }];
    self.currentPage++;
}

- (void)loadMoreItems
{
    if(!self.isCurrentlyLoad && !self.isEverythingLoaded){
        self.isCurrentlyLoad = YES;
        __weak CCPaginationDataProvider *weakSelf = self;
        [self loadItemsForPageNumber:self.currentPage successHandler:^(id responseObject) {
            NSDictionary *response = responseObject;
            weakSelf.arrayOfItems = [weakSelf.arrayOfItems arrayByAddingObjectsFromArray: response[CCResponseKeys.items]];
            weakSelf.isEverythingLoaded = [self checkIsComplete];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.tableViewWillReloadData object:nil];
            [weakSelf.targetTable reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.tableViewDidReloadData object:nil];
            
            weakSelf.isCurrentlyLoad = NO;
        }];
        self.currentPage++;
    }
}

- (BOOL)checkIsComplete
{
    if (self.arrayOfItems.count < self.totalNumber) {
        return NO;
    }
    else {
        return YES;
    }
}

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler {}

@end
