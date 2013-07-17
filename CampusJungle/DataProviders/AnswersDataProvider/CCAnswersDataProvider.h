//
//  CCAnswersDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 16.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPaginationDataProvider.h"

@interface CCAnswersDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *questionId;
- (void)deleteItem:(id)item;

@end
