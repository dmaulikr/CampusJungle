//
//  CCMarketNotesProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 13.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPaginationDataProvider.h"

@interface CCMarketNotesProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSDictionary *filters;
@property (nonatomic, strong) NSString *order;

@end
