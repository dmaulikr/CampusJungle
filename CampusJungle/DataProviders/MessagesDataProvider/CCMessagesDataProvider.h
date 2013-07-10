//
//  CCMessagesDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPaginationDataProvider.h"

@interface CCMessagesDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSDictionary *filters;

@end
