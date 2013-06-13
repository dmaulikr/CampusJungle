//
//  CCMarketNotesProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseDataProvider.h"

@interface CCMarketNotesProvider : CCBaseDataProvider

@property (nonatomic, strong) NSDictionary *filters;
@property (nonatomic, strong) NSString *query;
@property (nonatomic, strong) NSString *order;

@end
