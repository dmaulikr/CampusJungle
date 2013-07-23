//
//  CCBackToControllerTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 23.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBackToControllerTransaction.h"

@implementation CCBackToControllerTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(self.targetController);
    
    [self.navigation popToViewController:self.targetController animated:YES];
}

@end
