//
//  CCClassLocationsDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 08.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCPaginationDataProvider.h"

@protocol CCLocationDataProviderDelegate;

@interface CCClassLocationsDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *classId;

- (id)initWithDelegate:(id<CCLocationDataProviderDelegate>)delegate;

@end
