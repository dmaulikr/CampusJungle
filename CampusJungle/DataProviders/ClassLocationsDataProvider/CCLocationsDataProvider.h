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

@interface CCLocationsDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *classId;
@property (nonatomic, strong) NSString *groupId;

- (id)initWithDelegate:(id<CCLocationDataProviderDelegate>)delegate;

@end
