//
//  CCInviterTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 31.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCInviterTransaction.h"
#import "CCInviterSelectionController.h"

@implementation CCInviterTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    CCInviterSelectionController *inviterController = [CCInviterSelectionController new];
    inviterController.tutorialTransaction = self.tutorialTransaction;
    [self.navigation pushViewController:inviterController animated:YES];
}

@end
