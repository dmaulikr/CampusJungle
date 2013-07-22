//
//  CCAddGroupTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddGroupTransaction.h"
#import "CCAddGroupViewController.h"
#import "CCBackTransaction.h"

@implementation CCAddGroupTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(object);
    NSParameterAssert(self.navigation);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddGroupViewController *addGroupController = [CCAddGroupViewController new];
    [addGroupController setClassObject:object];
    addGroupController.backTransaction = backTransaction;
    [self.navigation pushViewController:addGroupController animated:YES];
}

@end
