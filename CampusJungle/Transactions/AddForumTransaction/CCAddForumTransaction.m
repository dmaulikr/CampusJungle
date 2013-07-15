//
//  CCAddForumTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 15.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCAddForumTransaction.h"
#import "CCAddForumViewController.h"

#import "CCBackTransaction.h"

@implementation CCAddForumTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddForumViewController *addForumController = [CCAddForumViewController new];
    [addForumController setClass:object];
    addForumController.backTransaction = backTransaction;
    
    [self.navigation pushViewController:addForumController animated:YES];
}

@end
