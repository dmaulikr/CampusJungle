//
//  CCPaginationDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBaseDataProvider.h"
#import "CCTypesDefinition.h"

#define firstPage 1

@interface CCPaginationDataProvider : CCBaseDataProvider

@property (nonatomic) long currentPage;
@property (nonatomic) BOOL isCurrentlyLoad;

- (void)loadItemsForPageNumber:(long)numberOfPage successHandler:(successWithObject)successHandler;
- (BOOL)checkIsComplete;

@end
