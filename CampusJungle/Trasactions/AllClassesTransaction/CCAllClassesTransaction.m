//
//  CCAllClassesTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/31/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAllClassesTransaction.h"
#import "CCClassesController.h"

@implementation CCAllClassesTransaction

- (void)perform
{
    NSParameterAssert(self.menuController);
    CCClassesController *classesController = [CCClassesController new];
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:classesController];
    
    self.menuController.centerPanel = centralNavigation;
}

@end
