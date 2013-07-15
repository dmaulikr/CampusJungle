//
//  CCTimeTableDataProvider.m
//  CampusJungle
//
//  Created by Vlad Korzun on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTimeTableDataProvider.h"

@implementation CCTimeTableDataProvider

- (id)init
{
    if(self = [super init]){
        self.arrayOfLessons = [NSMutableArray new];
        [self.arrayOfLessons addObject:@{@"timetable" : @"Add New Lesson"}];
    }
    return self;
}

- (void)loadItems
{
    self.arrayOfItems = self.arrayOfLessons;
    [self.targetTable reloadData];
    self.isEverythingLoaded = YES;
    self.totalNumber = self.arrayOfItems.count;
}

- (void)replaseTime:(NSDictionary *)time withTime:(NSDictionary *)newTime
{
    NSInteger oldTimeIndex = [self.arrayOfLessons indexOfObject:time];
    [self.arrayOfLessons replaceObjectAtIndex:oldTimeIndex withObject:newTime];
    [self.targetTable reloadData];
}

- (void)removeObject:(NSDictionary *)lesson
{
    [self.arrayOfLessons addObject:lesson];
    self.totalNumber = self.arrayOfLessons.count;
}

- (void)insertNewLesson:(NSDictionary *)lesson
{
    [self.arrayOfLessons insertObject:lesson atIndex:1];
    self.totalNumber = self.arrayOfLessons.count;
    [self.targetTable reloadData];
}

@end
