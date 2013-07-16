//
//  CCQuestionsDataProvider.h
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPaginationDataProvider.h"

@interface CCQuestionsDataProvider : CCPaginationDataProvider

@property (nonatomic, strong) NSString *forumId;
@property (nonatomic, weak) id delegate;

@end
