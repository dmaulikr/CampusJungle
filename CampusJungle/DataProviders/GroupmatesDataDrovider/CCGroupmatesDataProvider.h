//
//  CCGroupmatesDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPaginationDataProvider.h"

@class CCGroup;

@protocol CCGroupmatesDataProviderDelegate <NSObject>

- (void)didReceiveGroupmates;

@end

@interface CCGroupmatesDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) CCGroup *group;
- (void)setItemsPerPage:(NSInteger)itemsPerPage;
- (void)setNeedToSelectAllItems:(BOOL)selected;
- (void)setDelegate:(id<CCGroupmatesDataProviderDelegate>)delegate;

@end
