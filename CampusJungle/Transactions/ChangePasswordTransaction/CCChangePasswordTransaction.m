//
//  CCChangePasswordTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 06.08.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCChangePasswordTransaction.h"
#import "CCBackTransaction.h"
#import "CCChangePasswordViewController.h"

@implementation CCChangePasswordTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCChangePasswordViewController *changePasswordController = [CCChangePasswordViewController new];
    changePasswordController.backTransaction = backTransaction;
    [self.navigation pushViewController:changePasswordController animated:YES];
}

@end
