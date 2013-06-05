//
//  CCAddClassTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/3/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddClassTransaction.h"
#import "CCCreateClassController.h"

@implementation CCAddClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCCreateClassController *classesController = [[CCCreateClassController alloc] initWithCollegeID:object];
    [self.navigation pushViewController:classesController animated:YES];    
}

@end
