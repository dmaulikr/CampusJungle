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
#import "CCClass.h"

@implementation CCAddForumTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(self.navigation);
    NSParameterAssert(object);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCAddForumViewController *addForumController = [CCAddForumViewController new];
    if ([object isKindOfClass:[CCClass class]]) {
        [addForumController setClass:object];
    }
    else {
        [addForumController setGroup:object];
    }
    addForumController.backTransaction = backTransaction;
    
    [self.navigation pushViewController:addForumController animated:YES];
}

@end
