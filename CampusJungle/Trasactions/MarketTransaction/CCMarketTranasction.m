//
//  CCMarketTranasction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 12.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCMarketTranasction.h"
#import "CCMarketPlaceController.h"

@implementation CCMarketTranasction

- (void)perform
{
    NSParameterAssert(self.menuController);
   
    CCMarketPlaceController *marketController = [CCMarketPlaceController new];
    
    UINavigationController *centralNavigation = [[UINavigationController alloc] initWithRootViewController:marketController];
    [self.menuController setCenterPanel:centralNavigation];
}

@end
