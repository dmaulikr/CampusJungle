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

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCClassViewController *classController = [CCClassViewController new];
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classController];
    
    self.menuController.centerPanel = centralNavigation;
}

@end
