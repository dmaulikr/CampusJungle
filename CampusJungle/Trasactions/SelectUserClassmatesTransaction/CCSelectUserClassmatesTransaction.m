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
    NSParameterAssert(object);
    NSParameterAssert(self.navigation);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    id class = [object valueForKey:@"object"];
    id successBlock = [object valueForKey:@"successBlock"];
    
    CCSelectClassmatesViewController *selectClassmateController = [CCSelectClassmatesViewController new];
    selectClassmateController.backTransaction = backTransaction;
    [selectClassmateController setSuccessBlock:successBlock];
    [selectClassmateController setClass:class];
    [self.navigation pushViewController:selectClassmateController animated:YES];
}

@end
