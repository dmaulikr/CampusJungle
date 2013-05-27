//
//  CCSideMenuTransaction.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 5/27/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSideMenuTransaction.h"
#import "CCMenuController.h"

@implementation CCSideMenuTransaction

- (void)perform
{
    NSParameterAssert(self.centralPanel);
    JASidePanelController *rootController = [[JASidePanelController alloc] init];
    rootController.shouldDelegateAutorotateToVisiblePanel = NO;
    
    JASidePanelController *leftController = [[CCMenuController alloc] init];
	rootController.leftPanel = leftController;
	rootController.centerPanel = [[UINavigationController alloc] initWithRootViewController:self.centralPanel];
	
	[[UIApplication sharedApplication] keyWindow].rootViewController = rootController;
}

@end
