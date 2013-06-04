//
//  CCClassTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/29/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassTransaction.h"
#import "CCClassViewController.h"

@implementation CCClassTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    CCClassViewController *classController = [CCClassViewController new];
   // classController.class = object;
    
    [self.navigation pushViewController:classController animated:YES];
}

@end
