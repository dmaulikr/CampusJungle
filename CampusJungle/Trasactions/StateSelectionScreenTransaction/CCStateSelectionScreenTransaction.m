//
//  CCStateSelectionScreenTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 29.05.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCStateSelectionScreenTransaction.h"
#import "CCStateSelectionConroller.h"

@implementation CCStateSelectionScreenTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    
    CCStateSelectionConroller *stateSelectionController = [CCStateSelectionConroller new];

    [self.navigation pushViewController:stateSelectionController animated:YES];
}

@end
