//
//  CCCollegeSelectionTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCollegeSelectionTransaction.h"
#import "CCCollegeSelectionController.h"

@implementation CCCollegeSelectionTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCCollegeSelectionController *collegeSelectionController = [CCCollegeSelectionController new];
    collegeSelectionController.cityID = object;
    
    [self.navigation pushViewController:collegeSelectionController animated:YES];
}

@end
