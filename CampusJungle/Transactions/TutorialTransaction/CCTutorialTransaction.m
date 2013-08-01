//
//  CCTutorialTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCTutorialTransaction.h"
#import "CCTutorialController.h"

@implementation CCTutorialTransaction

- (void)perform
{
    CCTutorialController *tutorialController = [CCTutorialController new];
    tutorialController.loginTransaction = self.loginTransaction;
    [self.navigation pushViewController:tutorialController animated:YES];
}

@end
