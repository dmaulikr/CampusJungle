//
//  CCAppInviteDataSource.h
//  CampusJungle
//
//  Created by Yury Grinenko on 26.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCommonDataSource.h"
#import "CCAppInviteDataProvider.h"

@interface CCAppInviteDataSource : CCCommonDataSource

@property (nonatomic, strong) CCAppInviteDataProvider *dataProvider;

@end
