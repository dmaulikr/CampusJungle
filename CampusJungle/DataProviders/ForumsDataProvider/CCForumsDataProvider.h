//
//  CCForumsDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPaginationDataProvider.h"

@class CCGroup;

@interface CCForumsDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *classId;
@property (nonatomic, strong) NSString *groupId;

@end
