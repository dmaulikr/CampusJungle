//
//  CCGroupMessageTransaction.m
//  CampusJungle
//
//  Created by Yury Grinenko on 22.07.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCGroupMessageTransaction.h"
#import "CCBackTransaction.h"
#import "CCGroupMessageViewController.h"

@implementation CCGroupMessageTransaction

- (void)performWithObject:(id)object
{
    NSParameterAssert(object);
    NSParameterAssert(self.navigation);
    
    CCBackTransaction *backTransaction = [CCBackTransaction new];
    backTransaction.navigation = self.navigation;
    
    CCGroupMessageViewController *groupMessageController = [CCGroupMessageViewController new];
    [groupMessageController setGroup:object];
    groupMessageController.backTransaction = backTransaction;
    [self.navigation pushViewController:groupMessageController animated:YES];
}

@end
