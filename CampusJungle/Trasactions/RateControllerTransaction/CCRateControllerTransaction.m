//
//  CCRateControllerTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 10.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCRateControllerTransaction.h"
#import "CCRateController.h"

@implementation CCRateControllerTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    
    CCRateController *rateController = [CCRateController new];
    
    [self.navigation pushViewController:rateController animated:YES];

}

@end
