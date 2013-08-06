//
//  CCMarketBooksDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPaginationDataProvider.h"

@interface CCMarketBooksDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSDictionary *filters;
@property (nonatomic, strong) NSString *order;


@end
