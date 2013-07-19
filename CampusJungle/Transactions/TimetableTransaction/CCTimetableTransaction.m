//
//  CCTimetableTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTimetableTransaction.h"
#import "CCTimetableViewController.h"

@implementation CCTimetableTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCTimetableViewController *timetableController = [CCTimetableViewController new];
    [timetableController setClassObject:object];
    
    [self.navigation pushViewController:timetableController animated:YES];
}

@end
