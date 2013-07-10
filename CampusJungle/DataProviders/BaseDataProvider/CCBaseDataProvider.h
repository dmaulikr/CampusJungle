//
//  CCBaseDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCAPIProviderProtocol.h"

@interface CCBaseDataProvider : NSObject

@property (nonatomic) long totalNumber;
@property (nonatomic, strong) NSArray *arrayOfItems;
@property (nonatomic, strong) NSString *cellReuseIdentifier;

@property (nonatomic, weak) UITableView *targetTable;

@property (nonatomic, assign) BOOL isEverythingLoaded;
@property (nonatomic, strong) id<CCAPIProviderProtocol> ioc_apiProvider;

@property (nonatomic,strong) NSString *searchQuery;

- (void)loadItems;
- (void)loadMoreItems;
- (void)showErrorWhileLoading:(NSError *)error;
- (BOOL)isEmpty;

@end
