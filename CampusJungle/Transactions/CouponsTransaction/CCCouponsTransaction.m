//
//  CCCouponsTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 01.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCouponsTransaction.h"
#import "CCCouponsViewController.h"

@implementation CCCouponsTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(object);
    NSParameterAssert(self.navigation);
    
    CCCouponsViewController *couponsController = [CCCouponsViewController new];
    [couponsController setClassObject:object];
    [self.navigation pushViewController:couponsController animated:YES];
}

@end
