//
//  CCTimetableTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 18.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTimetableTransaction.h"
#import "CCTimetableViewController.h"
#import "CCEditClassTransaction.h"

@implementation CCTimetableTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    id classObject = [object valueForKey:@"class"];
    id previousController = [object valueForKey:@"controller"];
    
    CCEditClassTransaction *editTransaction = [CCEditClassTransaction new];
    editTransaction.navigation = self.navigation;
    
    CCTimetableViewController *timetableController = [CCTimetableViewController new];
    [timetableController setClassObject:classObject];
    timetableController.previousController = previousController;
    timetableController.editClassTransaction = editTransaction;
    
    editTransaction.classDataController = timetableController;
    [self.navigation pushViewController:timetableController animated:YES];
}

@end
