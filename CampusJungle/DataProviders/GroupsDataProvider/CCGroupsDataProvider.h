//
//  CCGroupsDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPaginationDataProvider.h"

@interface CCGroupsDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *classId;

@end
