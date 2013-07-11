//
//  CCSelectUserClassmatesTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectUserClassmatesTransaction.h"
#import "CCSelectClassmatesViewController.h"

@implementation CCSelectUserClassmatesTransaction

- (void)performWithObject:(id)object
{
    CCSelectClassmatesViewController *selectClassmateController = [CCSelectClassmatesViewController new];
    [self.navigation pushViewController:selectClassmateController animated:YES];
}

@end
