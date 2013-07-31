//
//  CCWalletTransaction.m
//  CampusJungle
//
//  Created by Vlad Korzun on 30.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCWalletTransaction.h"
#import "CCWalletController.h"

@implementation CCWalletTransaction

- (void)perform
{
    NSParameterAssert(self.navigation);
    
    CCWalletController *walletController = [CCWalletController new];
    [self.navigation pushViewController:walletController animated:YES];
    
}

@end
