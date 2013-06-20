//
//  CCCreateStuffTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 20.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateStuffTransaction.h"
#import "CCStuffCreationController.h"

@implementation CCCreateStuffTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);

    CCStuffCreationController *stuffCreationController = [CCStuffCreationController new];

    [self.navigation pushViewController:stuffCreationController animated:YES];
    
}

@end
