//
//  CCBaseReverseDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 17.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPaginationDataProvider.h"

@interface CCBaseReverseDataProvider : CCPaginationDataProvider

- (NSDictionary *)reverseItemsArrayInPaginationDictionary:(NSDictionary *)sourceDictionary;

@end
