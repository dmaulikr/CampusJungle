//
//  CCTimeTableDataProvider.h
//  CampusJungle
//
//  Created by Vlad Korzun on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseDataProvider.h"

@interface CCTimeTableDataProvider : CCBaseDataProvider

@property (nonatomic, strong) NSMutableArray *arrayOfLessons;

- (void)insertNewLesson:(NSDictionary *)lesson;
- (void)replaseTime:(NSDictionary *)time withTime:(NSDictionary *)newTime;
@end
