//
//  CCClassTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassTransaction.h"
#import "CCClassController.h"

@implementation CCClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCClassController *classController = [[CCClassController alloc] initWitchClass:object];
    [self.navigation pushViewController:classController animated:YES];
}

@end
