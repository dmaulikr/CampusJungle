//
//  CCAddClassTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/3/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddClassTransaction.h"
#import "CCCreateClassController.h"
#import "CCClassAddedTransaction.h"

@implementation CCAddClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    NSParameterAssert(self.inboxTransaction);
    
    CCCreateClassController *classesController = [[CCCreateClassController alloc] initWithCollegeID:object];
    
    CCClassAddedTransaction *classAddedTransaction = [CCClassAddedTransaction new];
    classAddedTransaction.navigation = self.navigation;
    classesController.classAddedTransaction = classAddedTransaction;
    classAddedTransaction.inboxTransaction = self.inboxTransaction;
    [self.navigation pushViewController:classesController animated:YES];    
}

@end
