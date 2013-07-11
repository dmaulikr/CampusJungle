//
//  CCSelectUserClassmatesTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 11.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCSelectUserClassmatesTransaction.h"
#import "CCSelectClassmatesViewController.h"
#import "CCBackTransaction.h"

@implementation CCSelectUserClassmatesTransaction

- (void)performWithObject:(id)object
{
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCSelectClassmatesViewController *selectClassmateController = [CCSelectClassmatesViewController new];
    selectClassmateController.backTransaction = backTransaction;
    [selectClassmateController setClass:object];
    [self.navigation pushViewController:selectClassmateController animated:YES];
}

@end
